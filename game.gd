extends Node
class_name Game

@export var center_stage : Stage
var rings : Array[Ring] = []
const DEF_click_max = 250.0
const DEF_click_min = 50.0
var click_max : float = DEF_click_max
var click_min : float = DEF_click_min
var segment_levels : PackedVector2Array = []

## Click Event Stuff
var ring_selected_id : int = -1
var ring_selected_rot : float = -1000
var click_on_pos : Vector2 = Vector2.ZERO
var ring_targets : PackedFloat32Array = []


func _ready() -> void:
	if !get_window().size_changed.is_connected(recenter):
		get_window().size_changed.connect(recenter)
	if center_stage == null:
		#center_stage = find_child("center")
		for c in get_children():
			if c is Stage:
				center_stage = c
	if center_stage != null:
		for c in center_stage.get_children():
			if c is Ring:
				rings.append(c)
	_calc_segment_levels(rings.size())
	## Setup base rotation values
	ring_targets.resize(rings.size())
	for i in rings.size():
		ring_targets[i] = rings[i].rotation


func recenter() -> void:
	print("Recenter")
	center_stage.position = get_window().size / 2
	print(center_stage.position)
	print("TODO Rescale CenterStage")
	#if rings.size() > 0:
		#for ring in rings:
			#ring.rescale()


func dial_ring_to(id : int, rot : float) -> void:
	rings[id].rotation = rot


func _process(delta: float) -> void:
	for i in rings.size():
		dial_ring_to(i, lerp_angle(rings[i].rotation, ring_targets[i], 8 * delta))


func _calc_segment_levels(steps : int):
	segment_levels.clear()
	segment_levels.resize(steps)
	var new_max = click_max - click_min
	var segment_size = new_max / steps
	var x = 0
	var y = segment_size
	for i in steps:
		segment_levels[i] = Vector2(x, y)
		x = y
		y += segment_size


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
		var local_pos : Vector2 = event.position - center_stage.global_position
		var dist : float = Vector2.ZERO.distance_to(local_pos)
		_active_ring_forget()
		if _check_segment(dist - click_min) >= 0:
			ring_selected_id = _check_segment(dist - click_min)
			ring_selected_rot = rings[ring_selected_id].rotation
			click_on_pos = local_pos
	else:
		_active_ring_forget()


func _move_event(event : InputEventMouseMotion):
	var localized_mouse_pos : Vector2 = event.position - center_stage.global_position
	var angle_a : float = Vector2.RIGHT.angle_to(click_on_pos.normalized())
	var angle_b : float = Vector2.RIGHT.angle_to(localized_mouse_pos.normalized())
	var angle_diff : float = angle_b - angle_a
	#print("AngleA: ", angle_a, " | AngleB: ", angle_b, " | AngleDiff: ", angle_diff)
	ring_targets[ring_selected_id] = ring_selected_rot + angle_diff
	#dial_ring_to(ring_selected_id, ring_selected_rot + angle_diff)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		_click_event(event)
	if event is InputEventMouseMotion and ring_selected_id >= 0:
		_move_event(event)
