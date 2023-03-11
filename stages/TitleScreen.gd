extends Node2D


signal level_changed

# warning-ignore:unused_signal
signal level_solved

# warning-ignore:unused_signal
signal player_died

export var level_number = 0


func _on_NextButton_pressed():
	emit_signal("level_changed", level_number)
