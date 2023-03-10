extends Node2D

signal level_changed

export var level_number = 0


func _on_NextButton_pressed():
	print("next button is pressed")
	emit_signal("level_changed", level_number)
