extends MarginContainer

signal start_game

func _on_Button_pressed():
	emit_signal("start_game")
