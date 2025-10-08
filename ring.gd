extends Node2D
class_name Ring

@export var level : int = 0
enum CUTOUT {A, B, C, D}
@export var cutout_shape : CUTOUT = CUTOUT.A

@onready var sprite : Sprite2D = $Sprite2D
@onready var light : PointLight2D = $PointLight2D


var light_rotate_var : float = 1.0


func _ready() -> void:
	light_rotate_var = randf_range(0.8, 2.0)
	#if randf() < 0.5:
		#light_rotate_var *= -1.0


func _process(delta: float) -> void:
	light.rotation += delta * light_rotate_var
