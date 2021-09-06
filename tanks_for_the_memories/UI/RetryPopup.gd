extends Control

signal retry
signal quit

func _on_Retry_pressed():
	emit_signal("retry")

func _on_Quit_pressed():
	emit_signal("quit")
