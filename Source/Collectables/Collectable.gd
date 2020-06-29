tool
extends Area2D
# Collectable send a signal when collected to PlayerData
# It passes self as argument so PlayerData can check what group we are in 
# Then player data deals with this information

signal collected(me)

func _ready() -> void:
	connect("collected", PlayerData, "_on_Collectable_collected")

func _on_body_entered(body: Node) -> void:
	emit_signal("collected",self)
	queue_free()

#warning for editor in case I forget to add node to group
func _get_configuration_warning() -> String:
	var warning: String = ""
	if get_groups() == []:
		warning = "Add node to a group"
	return warning
