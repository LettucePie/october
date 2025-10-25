extends Node
class_name Game

@export var ring_center : Node2D
var ring_levels : Array[Ring_Level] = []
const DEF_click_max = 250.0
const DEF_click_min = 50.0
var click_max : float = DEF_click_max
var click_min : float = DEF_click_min
var segment_levels : PackedVector2Array = []


func _ready() -> void:
	if !get_window().size_changed.is_connected(recenter):
		get_window().size_changed.connect(recenter)
	if ring_center == null:
		ring_center = find_child("center")
	if ring_center != null:
		for c in ring_center.get_children():
			if c is Ring_Level:
				ring_levels.append(c)
	_calc_segment_levels(ring_levels.size())


func recenter() -> void:
	print("Recenter")
	ring_center.position = get_window().size / 2
	print(ring_center.position)
	if ring_levels.size() > 0:
		for ring_level in ring_levels:
			ring_level.rescale()


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


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			var local_pos : Vector2 = event.position - ring_center.global_position
			var dist : float = Vector2.ZERO.distance_to(local_pos)
			print(local_pos, " | ", dist)
			print(_check_segment(dist - click_min))
