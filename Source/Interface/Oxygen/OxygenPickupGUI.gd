extends HBoxContainer 

var centered = false

func _ready() -> void:
	display_in_centre_of_screen()
	PlayerData.connect("oxygen_gui_updated",self,"_oxygen_gui_updated")
	_update_oxygen_textures()


func _oxygen_gui_updated():
	_update_oxygen_textures()


func _process(delta: float) -> void:
	if centered == false:
		display_in_centre_of_screen()
		centered = true
	print(margin_left)

func _update_oxygen_textures():
	var current_fill: float = 0 
	var current_oxygen: float = PlayerData.current_oxygen
	for child in get_children():
		var bubble: TextureProgress = child
		if current_oxygen - current_fill >= bubble.max_value:
			bubble.value = bubble.max_value
			current_fill += bubble.value
			print(current_fill)
		else:
			bubble.value = current_oxygen - current_fill
			current_fill += bubble.value


func display_in_centre_of_screen():
	var my_midpoint = (margin_right - margin_left)/2
	var screen_midpoint = GameManager.screen_size.x/2
	var new_left_margine = screen_midpoint - my_midpoint
	margin_left = new_left_margine
