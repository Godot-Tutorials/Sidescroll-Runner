extends Node

var screen_size: Vector2

func _ready() -> void:
	screen_size = get_viewport().size 

func on_VictoryMarker_player_won() -> void:
	print("player won")

