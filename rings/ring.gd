extends Node2D
class_name Ring
signal ring_solved(ring, tf)

## Gameplay Setups
@export var level : int = 0
enum CUTOUT {A, B, C, D}
@export var cutout_shape : CUTOUT = CUTOUT.A
@export var clearings : Array[Clearing] = []
@export var interactives : Array[Interactive] = []

## VFX
@onready var sprite : Sprite2D = $Sprite2D
@onready var light : PointLight2D = $PointLight2D

## Run-Time Dynamics
var light_rotate_var : float = 1.0
var solution : bool = false
var rot_target : float = 0.0


func _ready() -> void:
	light_rotate_var = randf_range(0.8, 2.0)
	if clearings.size() <= 0:
		for c in get_children():
			if c is Clearing:
				clearings.append(c)
	for c in clearings:
		if c.ring_owner != self:
			c.ring_owner = self
		if !c.solution_prox.is_connected(solution_proxima):
			c.solution_prox.connect(solution_proxima)


func _process(delta: float) -> void:
	light.rotation += delta * light_rotate_var
	self.rotation = lerp_angle(self.rotation, rot_target, 8 * delta)


func update_rot_target(new_target : float) -> void:
	var target : float = new_target
	for i in interactives:
		if i is Channel:
			target = clampf(
				target, 
				deg_to_rad(i.point_a_angle) - PI,
				deg_to_rad(i.point_b_angle)
			)
			print(target, " | ", rad_to_deg(target))
	rot_target = target


func solution_proxima(tf : bool) -> void:
	#print("Ring: ", self.name, " Solution: ", tf)
	solution = tf
	ring_solved.emit(self, tf)
