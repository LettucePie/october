extends Node2D
class_name Stage

@export var solution_area : Area2D
var rings : Array[Ring] = []
var solution_status : PackedByteArray = []


func _find_ring_children() -> void:
	rings.clear()
	for c in get_children():
		if c is Ring:
			rings.append(c)


func _connect_rings() -> void:
	if rings.size() > 0:
		for r in rings:
			if !r.ring_solved.is_connected(ring_status_report):
				r.ring_solved.connect(ring_status_report)


func _ready() -> void:
	_find_ring_children()
	_connect_rings()


func ring_status_report(ring : Ring, solved : bool) -> void:
	print("RING:" , ring, " REPORTS: ", solved, " to CENTER STAGE")
