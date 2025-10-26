extends Node2D
class_name Ring
signal ring_solved(ring, tf)

@export var level : int = 0
enum CUTOUT {A, B, C, D}
@export var cutout_shape : CUTOUT = CUTOUT.A
@export var clearings : Array[Clearing] = []
@export var interactives : Array = []

@onready var sprite : Sprite2D = $Sprite2D
@onready var light : PointLight2D = $PointLight2D


var light_rotate_var : float = 1.0
var solution : bool = false


func _ready() -> void:
	light_rotate_var = randf_range(0.8, 2.0)
	if clearings.size() <= 0:
		print("**ERROR** UNSOLVABLE RING")
	else:
		for c in clearings:
			if c.ring_owner != self:
				c.ring_owner = self
			if !c.solution_prox.is_connected(solution_proxima):
				c.solution_prox.connect(solution_proxima)


func _process(delta: float) -> void:
	light.rotation += delta * light_rotate_var


func solution_proxima(tf : bool) -> void:
	#print("Ring: ", self.name, " Solution: ", tf)
	solution = tf
	ring_solved.emit(self, tf)
