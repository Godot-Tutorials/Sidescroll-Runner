extends HBoxContainer

var coins_collected: int

onready var vanish_timer: Timer = $VanishTimer
onready var coin_counter: Label = $CoinCounter

func _ready() -> void:
	_vanish()
	PlayerData.connect("gui_updated",self,"_on_GUI_updated")
	#connect(signal: String, target: Object, method: String, binds: Array = [  ], flags: int = 0)


func _on_Timer_timeout() -> void:
	_vanish()


func _on_GUI_updated():
	_update_label()
	_appear()
	vanish_timer.start()


func _vanish():
	modulate = Color( 1, 1, 1, 0 )


func _appear():
	modulate = Color( 1, 1, 1, 1 )


func _update_label():
	coins_collected = PlayerData.coins_collected_this_level
	coin_counter.text = str(coins_collected)
