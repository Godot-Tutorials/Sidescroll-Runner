extends Node

# Stores all player data to be transfered between a scenes and will eventually 
# be used to create a save for the game from 

signal coin_gui_updated
signal oxygen_gui_updated
signal out_of_oxygen

const OXYGEN_LOST_PER_DISTANCE: float = 0.5

var coins_collected_this_level: int = 0
var max_oxygen: int = 3
var current_oxygen: float = 3.5 #max_oxygen

func _on_Collectable_collected(obj:Area2D) -> void:
	# Check in what group objects are and decides what to do with this information
	if obj.is_in_group("coins"): # change that later to different groups that I used
		_coin_collected()
	elif obj.is_in_group("oxygen"): # change that later to different groups that I used
		_oxygen_collected()
	
	if obj.get_groups() == []:
		print(obj.name, " is not in any group")

func _coin_collected():
	coins_collected_this_level +=1
	emit_signal("coin_gui_updated")

func _on_Player_distance_milestone_achived() -> void:
	current_oxygen -= OXYGEN_LOST_PER_DISTANCE
	emit_signal("oxygen_gui_updated")
	if current_oxygen <= 0:
		emit_signal("out_of_oxygen")

func _oxygen_collected():
	current_oxygen +=1
	emit_signal("oxygen_gui_updated")
