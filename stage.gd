extends Node2D
class_name Stage

@export var solution_area : Area2D
var rings : Array[Ring] = []


func _find_ring_children() -> void:
	rings.clear()
	for c in get_children():
		if c is Ring:
			rings.append(c)


func _ready() -> void:
	_find_ring_children()
