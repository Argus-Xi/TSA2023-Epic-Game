extends Node

onready var current_level = $Menu

func _ready() -> void:
	current_level.connect("level_changed", self, "handle_next_level")

func handle_next_level(current_level_number: int):
	print("handle next level function has been called")
	var next_level
	
	next_level = load("res://stages/Level" + str(current_level_number + 1) + ".tscn").instance()
	add_child(next_level)
	next_level.connect("level_changed", self, "handle_next_level")
	current_level.queue_free()
	current_level = next_level
