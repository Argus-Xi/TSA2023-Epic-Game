extends Node2D

signal level_changed

signal level_solved

signal player_died

export var level_number = 0

var level_running = true

var level_time = 0

var score = 0

func _process(delta):
	if level_running == true:
		level_time += delta
		$TimeLabel.text = str(stepify(level_time, 0.01))


# This is redundant because the main screen will have a button in the solve screen, but that's okay
func _on_NextButton_pressed():
	emit_signal("level_changed", level_number)

#  Functions to send level events up to SceneSwitcher

func solved():   # Calculates the score and sends it to the SceneSwitcher for the UI
	score = (1 / level_time) * 100
	emit_signal("level_solved", score)
	level_running = false
	
func died():
	emit_signal("player_died")
	level_running = false






# TEMPORARY PLACEHOLDER SIGNALS FOR SIGNALS FROM LASER RECEPTOR AND PLAYERS


func _on_SolveButton_pressed():
	solved()


func _on_DieButton_pressed():
	died()
