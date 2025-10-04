extends Node2D
class_name Ring

@export var offset : Vector2 = Vector2.ZERO
@export var radius : float = 15.0
@export var color : Color = Color.WHITE

func _process(delta: float) -> void:
	radius += delta
	queue_redraw()

func _draw() -> void:
	draw_circle(offset, radius, color)
