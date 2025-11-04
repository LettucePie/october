extends Node
class_name Game

const BASE_WINDOW : Vector2 = Vector2(700, 500)

@export var center_stage : Stage
@onready var waypoint : Waypoint = $waypoint
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
	recenter()


func recenter() -> void:
	var win_size : Vector2i = get_window().size
	center_stage.position = win_size / 2
	var factor_a : float = BASE_WINDOW.y
	var factor_b : float = win_size.y
	if win_size.x < win_size.y:
		print("Go Vertical")
		factor_a = BASE_WINDOW.x
		factor_b = win_size.x
	else:
		print("Go Horizontal")
	center_stage.rescale(Vector2(factor_b / factor_a, factor_b / factor_a))
	#waypoint.set_scale(Vector2(factor_b / factor_a, factor_b / factor_a))


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
