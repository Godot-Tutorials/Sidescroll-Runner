extends Node

# Stores all player data to be transfered between a scenes and will eventually 
# be used to create a save for the game from 

func _on_Collectable_collected(obj:Area2D) -> void:
	# Check in what group objects are and decides what to do with this information
	if obj.is_in_group("group1"): # change that later to different groups that I used
		pass
	elif obj.is_in_group("group2"): # change that later to different groups that I used
		pass
	else:
		print(obj.name, " is not in any group")
