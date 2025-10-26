extends Node
class_name Game

@export var center_stage : Stage
#var rings : Array[Ring] = []



func _ready() -> void:
	if !get_window().size_changed.is_connected(recenter):
		get_window().size_changed.connect(recenter)
	if center_stage == null:
		#center_stage = find_child("center")
		for c in get_children():
			if c is Stage:
				center_stage = c


func recenter() -> void:
	print("Recenter")
	center_stage.position = get_window().size / 2
	print(center_stage.position)
	print("TODO Rescale CenterStage")
	#if rings.size() > 0:
		#for ring in rings:
			#ring.rescale()
