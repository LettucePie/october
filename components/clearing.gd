extends Area2D
class_name Clearing

signal solution_prox(tf)
var ring_owner : Ring


func _ready() -> void:
	if ring_owner == null:
		if get_parent() is Ring:
			ring_owner = get_parent()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Solution"):
		emit_signal("solution_prox", true)


func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("Solution"):
		emit_signal("solution_prox", false)
