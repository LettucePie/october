extends Node2D
class_name Cutout



func _draw() -> void:
	draw_rect(
		Rect2(0, -20, 500, 40),
		Color.BLACK,
		true,
		-1.0,
		true
	)
