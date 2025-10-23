extends Node
class_name Game

@onready var center_node : Node2D = $center

func _ready() -> void:
	if !get_window().size_changed.is_connected(recenter):
		get_window().size_changed.connect(recenter)


func recenter() -> void:
	print("Recenter")
	center_node.position = get_window().size / 2
	print(center_node.position)
