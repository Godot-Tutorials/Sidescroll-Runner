tool
extends Node2D

export var uncenter_sprites: bool = true
export var center_colisions: bool = false

func _process(delta: float) -> void:
	if uncenter_sprites:
		var children = get_children()
		for child in children:
			child.centered = false
	if center_colisions:
		var children = get_children()
		for child in children:
			# only run if there are actually collisions
			if child.get_child(0) != null:
				if child.get_child(0).get_child(0) != null:
					var collision = child.get_child(0).get_child(0)
					#square collisions
					if collision.shape == load("res://Source/Tiles/SquareTileColission.tres"):
						child.get_child(0).get_child(0).position = Vector2(64,64)
					# half slabs
					if collision.shape == load("res://Source/Tiles/HalfTileColission.tres"):
						child.get_child(0).get_child(0).position = Vector2(64,37)
					
