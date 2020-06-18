extends Node2D

func _ready() -> void:
	$DebugOverlay.add_stat("Player Position", $Player,"position", false, Color.white)
