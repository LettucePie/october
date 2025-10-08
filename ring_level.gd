extends Node2D
class_name Ring_Level

@export var ring_level : int = 0
@export var ring_scenes : Array[PackedScene] = []


func _ready():
	var ring : Ring = ring_scenes.front().instantiate()
	self.add_child(ring)
