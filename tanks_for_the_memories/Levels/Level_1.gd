extends Node2D

func _ready():
	$HUD.set_level("Level 1")

func _on_Player_hit(health):
	$HUD.set_health(health)
