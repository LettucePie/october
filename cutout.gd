extends Node2D
class_name Cutout



func _draw() -> void:
	#draw_rect(
		#Rect2(-250, -250, 500, 500),
		#Color.WHITE,
		#true,
		#-1.0,
		#false
	#)
	#draw_rect(
		#Rect2(0, -20, 500, 40),
		#Color.BLACK,
		#true,
		#-1.0,
		#true
	#)
	draw_rect(
		Rect2(-250, -250, 250, 500),
		Color.WHITE,
		true,
		-1.0,
		false
	)
	draw_rect(
		Rect2(0, -250, 250, 230),
		Color.WHITE,
		true,
		-1.0,
		false
	)
	draw_rect(
		Rect2(0, 20, 250, 230),
		Color.WHITE,
		true,
		-1.0,
		false
	)
