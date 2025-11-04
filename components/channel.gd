@tool
extends Interactive
class_name Channel

const DEF_radius : float = 50.0
const DEF_outer_arc_w : float = 18
const DEF_outer_cap_r : float = 13
const DEF_inner_arc_w : float = 16
const DEF_inner_cap_r : float = 12
@export_range(1.0, 4.0, 1.0) var radius_multiplier : float = 1.0
@export_range(0.0, 360.0, 15.0) var point_a_angle : float = 90
@export_range(0.0, 360.0, 15.0) var point_b_angle: float = 180
var point_a : Vector2 = Vector2.ZERO
var point_b : Vector2 = Vector2.ZERO
var arc_points : int = 10


func _process(delta) -> void:
	point_a = self.position + (
		Vector2.RIGHT.rotated(deg_to_rad(point_a_angle)) * (DEF_radius * radius_multiplier + 25)
	)
	point_b = self.position + (
		Vector2.RIGHT.rotated(deg_to_rad(point_b_angle)) * (DEF_radius * radius_multiplier + 25)
	)
	arc_points = 10 + int(3 * radius_multiplier)
	queue_redraw()


func _draw() -> void:
	## Backdrop Channel
	## Main Arc
	draw_arc(
		self.position, 
		DEF_radius * radius_multiplier + 25,
		deg_to_rad(point_a_angle),
		deg_to_rad(point_b_angle),
		arc_points,
		Color.BLACK,
		DEF_outer_arc_w,
		true
		)
	## End Caps
	draw_circle(
		point_a,
		DEF_outer_cap_r,
		Color.BLACK,
		true,
		-1.0,
		true
	)
	draw_circle(
		point_b,
		DEF_outer_cap_r,
		Color.BLACK,
		true,
		-1.0,
		true
	)
	## Inside Channel
	## Main Arc
	draw_arc(
		self.position, 
		DEF_radius * radius_multiplier + 25,
		deg_to_rad(point_a_angle),
		deg_to_rad(point_b_angle),
		arc_points,
		Color.WHITE,
		DEF_inner_arc_w,
		true
		)
	## End Caps
	draw_circle(
		point_a,
		DEF_inner_cap_r,
		Color.WHITE,
		true,
		-1.0,
		true
	)
	draw_circle(
		point_b,
		DEF_inner_cap_r,
		Color.WHITE,
		true,
		-1.0,
		true
	)
