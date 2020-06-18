extends DebugManager

func _ready() -> void:
	print("Hi")
	var player = get_node_from_path("Player")
	DebugOverlay.add_stat("Player Position", player,"position", false)
	DebugOverlay.add_stat("Player Velocity", player,"velocity", false )
	DebugOverlay.add_stat("Is on Floor", player,"is_on_floor", true )
