extends Node2D

const Level_1 = preload("res://Levels/Level_1.tscn")
const Level_2 = preload("res://Levels/Level_2.tscn")
const Level_3 = preload("res://Levels/Level_3.tscn")
const Level_4 = preload("res://Levels/Level_4.tscn")
const Level_5 = preload("res://Levels/Level_5.tscn")
const Level_6 = preload("res://Levels/Level_6.tscn")
const Level_7 = preload("res://Levels/Level_7.tscn")
const Level_8 = preload("res://Levels/Level_8.tscn")
const Level_9 = preload("res://Levels/Level_9.tscn")
const Level_10 = preload("res://Levels/Level_10.tscn")

const levels = [
	Level_1, 
	Level_2,
	Level_3,
	Level_4,
	Level_5,
	Level_6,
	Level_7,
	Level_8,
	Level_9,
	Level_10,
]

var currentLevelIndex
var currentLevelInstance

func _ready():
	$RetryPopup.hide()
	$NextLevel.hide()
	$Victory.hide()
	$Music.play()


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
	$Lose.play()

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
	$Win.play()
	for bullet in get_tree().get_nodes_in_group("bullets"):
		bullet.queue_free()
		
	var num_levels = levels.size()
	if currentLevelIndex + 1 < num_levels:
		$NextLevel.show()
	else:
		$Victory.show()
		$Music.stop()
		$Applause.play()
		

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
	$Applause.stop()
	$Music.play()
