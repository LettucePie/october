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
	if !center_stage.stage_solved.is_connected(stage_solved):
		center_stage.stage_solved.connect(stage_solved)


func recenter() -> void:
	print("Recenter")
	center_stage.position = get_window().size / 2
	print(center_stage.position)
	print("TODO Rescale CenterStage")
	#if rings.size() > 0:
		#for ring in rings:
			#ring.rescale()


func stage_solved() -> void:
	print("STAGE SOLVED")


func _process(delta: float) -> void:
	## TODO test only
	if center_stage != null:
		var lineout = "Stage: "
		if center_stage._check_solution():
			lineout += "SOLVED"
		else:
			lineout += "wrong"
		$Control/status.text = lineout
