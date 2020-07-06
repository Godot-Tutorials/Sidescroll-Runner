extends DebugManager

func pass_stats():
	var player = get_node_from_path("Player")
	emit_signal("stat_passed","Player Position", player,"position", false)
	emit_signal("stat_passed","Player Velocity", player,"velocity", false)
	emit_signal("stat_passed", "Is on Floor", player,"is_on_floor", true)
	emit_signal("stat_passed","Can Coyote Jump", player,"can_coyote_jump", false)
	emit_signal("stat_passed","is_active", player,"is_active", false)
