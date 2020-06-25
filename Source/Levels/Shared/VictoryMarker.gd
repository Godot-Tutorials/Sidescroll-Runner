extends Position2D

# If player position.x is greater than marker player wins
# Marker will send signal to game manager to decide how to handle it

signal player_won

var is_player_winner: bool = false
var player :Player

func _ready() -> void:
	connect("player_won",GameManager,"on_VictoryMarker_player_won")

func _process(delta: float) -> void:
	player = get_tree().current_scene.find_node("Player")
	if player and not is_player_winner:
		if player.global_position.x > global_position.x:
			is_player_winner = true
			emit_signal("player_won")
