@tool
extends Node2D
class_name Channel

const DEF_radius : float = 50.0
@export_range(1.0, 4.0, 1.0) var radius_multiplier : float = 1.0
@export_range(0.0, 360.0, 15.0) var point_a_angle : float = 90
@export_range(0.0, 360.0, 15.0) var point_b_angle: float = 180
var point_a : Vector2 = Vector2.ZERO
var point_b : Vector2 = Vector2.ZERO


func _process(delta) -> void:
	point_a = self.position + (Vector2.RIGHT.rotated(deg_to_rad(point_a_angle)) * (DEF_radius * radius_multiplier))
	point_b = self.position + (Vector2.RIGHT.rotated(deg_to_rad(point_b_angle)) * (DEF_radius * radius_multiplier))
	queue_redraw()


func _draw() -> void:
	draw_arc(
		self.global_position, 
		DEF_radius * radius_multiplier + 25,
		deg_to_rad(point_a_angle),
		deg_to_rad(point_b_angle),
		12,
		Color.CHARTREUSE,
		20,
		true
		)
