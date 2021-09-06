extends Node2D

signal win
signal fail

var won = false

func _ready():
	$HUD.set_level("Level 10")
	$HUD.set_health_max($Player.health)
	
	for mob in get_tree().get_nodes_in_group("mobs"):
		mob.player = $Player

func _physics_process(delta):
	var mobs = get_tree().get_nodes_in_group("mobs")
	
	if mobs.size() == 0 and !won:
		emit_signal("win")
		won = true

func _on_Player_hit(health):
	$HUD.set_health(health)

func _on_Player_dead():
	yield(get_tree().create_timer(1), "timeout")
	emit_signal("fail")


