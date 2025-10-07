extends Node2D
class_name Ring

const RADIUS_MIN : float = 30
const RADIUS_MAX : float = 230
const SEG_MIN : int = 15
const SEG_MAX : int = 125

@export var offset : Vector2 = Vector2.ZERO
@export var radius : float = clampf(20, RADIUS_MIN, RADIUS_MAX)
@export var segments : int = 10
@export var color : Color = Color.WHITE
@export var width : float = 10.0

## Testing
var grow : float = 0.6


func _process(delta: float) -> void:
	var radius_percent = inverse_lerp(RADIUS_MIN, RADIUS_MAX, radius)
	radius_percent = clamp(radius_percent + grow * delta, 0.0, 1.0)
	radius = lerpf(RADIUS_MIN, RADIUS_MAX, radius_percent)
	if (radius_percent >= 1.0 and grow > 0.0) \
	or (radius_percent <= 0.0 and grow < 0.0):
		grow *= -1.0
	segments = roundi(lerp(SEG_MIN, SEG_MAX, radius_percent))
	queue_redraw()


func _draw() -> void:
	#draw_circle(offset, radius, color)
	draw_arc(
		Vector2.ZERO,
		radius,
		0,
		PI * 2,
		segments,
		color,
		width,
		true
		)
