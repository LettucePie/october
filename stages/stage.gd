extends Node2D
class_name Stage
signal stage_solved()

@export var solution_area : Area2D
var rings : Array[Ring] = []
var solution_status : Array[bool] = []

const DEF_click_max = 250.0
const DEF_click_min = 50.0
var click_max : float = DEF_click_max
var click_min : float = DEF_click_min
var segment_levels : PackedVector2Array = []

## Click Event Stuff
var ring_selected_id : int = -1
var ring_selected_rot : float = -1000
var click_on_pos : Vector2 = Vector2.ZERO


func _find_ring_children() -> void:
	rings.clear()
	for c in get_children():
		if c is Ring:
			rings.append(c)


func _connect_rings() -> void:
	if rings.size() > 0:
		for r in rings:
			if !r.ring_solved.is_connected(ring_status_report):
				r.ring_solved.connect(ring_status_report)
			r.update_rot_target(r.rotation)


func _calc_segment_levels(steps : int):
	segment_levels.clear()
	segment_levels.resize(steps)
	var new_max = (click_max * scale.x) - (click_min * scale.x)
	var segment_size = new_max / steps
	var x = 0
	var y = segment_size
	for i in steps:
		segment_levels[i] = Vector2(x, y)
		x = y
		y += segment_size
	#print("Calculated Segment Levels:\n", segment_levels)


func rescale(new_scale : Vector2) -> void:
	set_scale(new_scale)
	_calc_segment_levels(rings.size())


func _ready() -> void:
	_find_ring_children()
	_connect_rings()
	_calc_segment_levels(rings.size())
	solution_status.resize(rings.size())
	for val in solution_status:
		val = false


func _snap_ring_to_solution(id : int) -> void:
	#print("Snapping Ring: ", id)
	var ring : Ring = rings[id]
	var ring_rot : float = ring.rotation
	var tau_count : int = floori(absf(ring_rot) / TAU)
	var ring_rot_taud : float = absf(ring_rot) - (tau_count * TAU)
	if ring_rot_taud / TAU > 0.9:
		ring_rot_taud -= TAU
	var viable_angles : PackedFloat32Array = []
	for clearing in ring.clearings:
		viable_angles.append(Vector2.RIGHT.angle_to(clearing.position.normalized()))
	var closest_snap_angle : float = viable_angles[0]
	var max_dist : float = TAU
	for va in viable_angles:
		var dist : float = absf(va - ring_rot_taud)
		if dist <= max_dist:
			max_dist = dist
			closest_snap_angle = va
	var new_target = closest_snap_angle
	if tau_count > 0:
		new_target += (TAU * tau_count)
	if ring_rot_taud / PI > 1:
		new_target += PI
	if ring_rot < 0:
		new_target *= -1.0
	rings[id].update_rot_target(new_target)


func _check_solution() -> bool:
	var result : bool = false
	if rings.size() == solution_status.size():
		var solved : bool = true
		for status in solution_status:
			if status != true:
				solved = false
		result = solved
	return result


func _check_segment(dist : float) -> int:
	var result : int = -1
	for i in segment_levels.size():
		var segment : Vector2 = segment_levels[i]
		if dist >= segment.x and dist < segment.y:
			result = i
	return result


func _active_ring_forget() -> void:
	ring_selected_id = -1
	ring_selected_rot = -1000
	click_on_pos = Vector2.ZERO


func _click_event(event : InputEventMouseButton):
	if event.pressed:
		var local_pos : Vector2 = event.position - global_position
		var dist : float = Vector2.ZERO.distance_to(local_pos)
		_active_ring_forget()
		if _check_segment(dist - (click_min * scale.x)) >= 0:
			ring_selected_id = _check_segment(dist - (click_min * scale.x))
			ring_selected_rot = rings[ring_selected_id].rotation
			click_on_pos = local_pos
	else:
		if ring_selected_id >= 0:
			if solution_status[ring_selected_id]:
				_snap_ring_to_solution(ring_selected_id)
		_active_ring_forget()


func _move_event(event : InputEventMouseMotion):
	var localized_mouse_pos : Vector2 = event.position - global_position
	var angle_a : float = Vector2.RIGHT.angle_to(click_on_pos.normalized())
	var angle_b : float = Vector2.RIGHT.angle_to(localized_mouse_pos.normalized())
	var angle_diff : float = angle_b - angle_a
	rings[ring_selected_id].update_rot_target(ring_selected_rot + angle_diff)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		_click_event(event)
	if event is InputEventMouseMotion and ring_selected_id >= 0:
		_move_event(event)


func ring_status_report(ring : Ring, solved : bool) -> void:
	var idx = rings.find(ring)
	solution_status[idx] = solved
	if ring_selected_id != idx and solved:
		_snap_ring_to_solution(idx)
	if _check_solution():
		emit_signal("stage_solved")
