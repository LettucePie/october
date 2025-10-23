extends Node2D
class_name Ring_Level

@export var ring_level : int = 0
@export var ring_scenes : Array[PackedScene] = []
const DEF_click_max = 250.0
const DEF_click_min = 50.0
var click_max : float = DEF_click_max
var click_min : float = DEF_click_min
var segment_levels : PackedVector2Array = []


func _ready():
	var ring : Ring = ring_scenes.front().instantiate()
	self.add_child(ring)
	_calc_segment_levels()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			var local_pos : Vector2 = event.position - self.global_position
			var dist : float = Vector2.ZERO.distance_to(local_pos)
			print(local_pos, " | ", dist)
			print(_check_segment(dist - click_min))


func rescale():
	print("Size Changing Stuff Here")
	click_max = DEF_click_max * scale.x
	click_min = DEF_click_min * scale.x
	_calc_segment_levels()


func _calc_segment_levels():
	segment_levels.clear()
	segment_levels.resize(4)
	var new_max = click_max - click_min
	var segment_size = new_max / 4
	segment_levels[0] = Vector2(0, segment_size)
	segment_levels[1] = Vector2(segment_levels[0].y, segment_levels[0].y + segment_size)
	segment_levels[2] = Vector2(segment_levels[1].y, segment_levels[1].y + segment_size)
	segment_levels[3] = Vector2(segment_levels[2].y, segment_levels[2].y + segment_size)


func _check_segment(dist : float) -> int:
	var result : int = -1
	
	for i in segment_levels.size():
		var segment : Vector2 = segment_levels[i]
		if dist >= segment.x and dist < segment.y:
			result = i
	
	return result
