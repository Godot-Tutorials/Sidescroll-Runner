extends DebugManager

func pass_stats():
	var player = get_node_from_path("Player")
	#emit_signal("stat_passed","Player Position", player,"position", false)
	#emit_signal("stat_passed","Player Velocity", player,"velocity", false)
	#emit_signal("stat_passed", "Is Player on Floor", player,"is_on_floor", true)
	emit_signal("stat_passed","Can Player Coyote Jump", player,"can_coyote_jump", false)
	#emit_signal("stat_passed","Is Player Active", player,"is_active", false)
	emit_signal("stat_passed","Player Multijump Count", player,"multijump_count", false)
	emit_signal("stat_passed","Can Multjump", player,"can_multijump", false, "fuchsia")
	emit_signal("stat_passed","Player is jumping", player,"is_jumping", false)
