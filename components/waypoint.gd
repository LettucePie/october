extends Node2D
class_name Waypoint

## Triangle Drawing Help
var point_dir : Vector2 = Vector2.RIGHT
@onready var base1_dir : Vector2 = Vector2.RIGHT.rotated(PI * -0.75)
@onready var base2_dir : Vector2 = Vector2.RIGHT.rotated(PI * 0.75)
## Dynamics
var tri_scale : float = 25.0
var rot_offset : float = 0.0
var solver_edge : Vector2 = Vector2.RIGHT

func _draw() -> void:
	var center : Vector2 = get_window().size / 2
	var center_tri : PackedVector2Array = [
		center + (point_dir.rotated(rot_offset) * tri_scale),
		center + (base1_dir.rotated(rot_offset) * tri_scale),
		center + (base2_dir.rotated(rot_offset) * tri_scale),
		center + (point_dir.rotated(rot_offset) * tri_scale)
	]
	draw_polyline(center_tri, Color.WHITE, 2.5, true)
	## Edge Triangle
	var edge : Vector2 = center
	edge.x += center.x * 0.8
	var edge_tri : PackedVector2Array = [
		edge + (point_dir.rotated(rot_offset + PI) * (tri_scale * 0.9)),
		edge + (base1_dir.rotated(rot_offset + PI) * (tri_scale * 0.9)),
		edge + (base2_dir.rotated(rot_offset + PI) * (tri_scale * 0.9)),
		edge + (point_dir.rotated(rot_offset + PI) * (tri_scale * 0.9)),
	]
	draw_polyline(edge_tri, Color.RED, 2.0, true)


func rescale() -> void:
	pass
	## Figure out the size we want for our triangle, as well as if we're still
	## orientated horizontal or vertical
	# _Draw
