extends HBoxContainer

var coins_collected: int

onready var vanish_timer: Timer = $VanishTimer
onready var coin_counter: Label = $CoinCounter

func _ready() -> void:
	_vanish()
	PlayerData.connect("coin_gui_updated",self,"_coin_gui_updated")


func _on_Timer_timeout() -> void:
	_vanish()


func _coin_gui_updated():
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
