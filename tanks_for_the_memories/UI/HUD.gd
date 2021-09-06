extends Control

func set_health(health):
	$HealthBar.value = health
	
func set_health_max(health):
	$HealthBar.max_value = health
	$HealthBar.value = health

func set_level(level_text):
	$Level.text = level_text
