extends Node2D


signal level_changed

signal level_solved

signal player_died

export var level_number = 0


func _on_NextButton_pressed():
	emit_signal("level_changed", level_number)
