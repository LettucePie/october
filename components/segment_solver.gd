extends Node2D
class_name SegmentSolver

func _ready() -> void:
	get_window().size_changed.connect(_resize)


func _resize():
	var lineout : String = "SegmentSolver Report: "
	var prev_pos : Vector2 = self.global_position
	for c in get_children():
		lineout += "\n" + c.name + " : " + str(c.global_position) + " dist: " + str(c.global_position - prev_pos)
		prev_pos = c.global_position
	print(lineout)
