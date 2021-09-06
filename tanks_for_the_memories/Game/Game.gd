extends Node2D

const Level_1 = preload("res://Levels/Level_1.tscn")

const levels = [Level_1, Level_1]

var currentLevelIndex
var currentLevelInstance

func _ready():
	$RetryPopup.hide()
	$NextLevel.hide()
	$Victory.hide()

func _on_MainMenu_start_game():
	$MainMenu.hide()
	_set_current_level(0)

func _set_current_level(index):
	currentLevelIndex = index
	currentLevelInstance = levels[index].instance()
	currentLevelInstance.connect("fail", self, "_level_failed")
	currentLevelInstance.connect("win", self, "_level_won")
	$Levels.add_child(currentLevelInstance)
	
func _level_failed():
	$RetryPopup.show()

func _on_RetryPopup_quit():
	currentLevelInstance.queue_free()
	$MainMenu.show()
	$RetryPopup.hide()
	currentLevelIndex = 0

func _on_RetryPopup_retry():
	currentLevelInstance.queue_free()
	_set_current_level(currentLevelIndex)
	$RetryPopup.hide()

func _level_won():
	for bullet in get_tree().get_nodes_in_group("bullets"):
		bullet.queue_free()
		
	var num_levels = levels.size()
	if currentLevelIndex + 1 < num_levels:
		$NextLevel.show()
	else:
		$Victory.show()

func _on_NextLevel_pressed():
	currentLevelIndex += 1
	currentLevelInstance.queue_free()
	_set_current_level(currentLevelIndex)
	$NextLevel.hide()

func _on_Victory_back():
	$RetryPopup.hide()
	$NextLevel.hide()
	$Victory.hide()
	$MainMenu.show()
