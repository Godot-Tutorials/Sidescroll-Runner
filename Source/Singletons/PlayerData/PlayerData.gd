extends Node

# Stores all player data to be transfered between a scenes and will eventually 
# be used to create a save for the game from 

signal gui_updated
signal out_of_energy

var coins_collected_this_level: int = 0
var max_energy: int = 3
var current_energy: int = max_energy

func _on_Collectable_collected(obj:Area2D) -> void:
	# Check in what group objects are and decides what to do with this information
	if obj.is_in_group("coins"): # change that later to different groups that I used
		_coin_collected()
	elif obj.is_in_group("group2"): # change that later to different groups that I used
		pass
	
	if obj.get_groups() == []:
		print(obj.name, " is not in any group")

func _coin_collected():
	coins_collected_this_level +=1
	emit_signal("gui_updated")

func on_Player_distance_milestone_achived() -> void:
	current_energy -= 1
	print(current_energy)
	if current_energy < 0:
		emit_signal("out_of_energy")
