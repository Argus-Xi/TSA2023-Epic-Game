extends Node

onready var level_container = $LevelContainer  # child that contains the levels below the UI of SceneSwitcher

onready var current_level = $LevelContainer/TitleScreen  # Initiates current_level variable with the Title Screen

onready var menu_screen = $MenuScreen  # menu screen UI reference

var max_number_levels = 3   # Set number of levels to be cycled through (including Level0 or TitleScreen)

func _ready() -> void:
	current_level.connect("level_changed", self, "handle_next_level")

func handle_next_level(current_level_number: int):
	print("handle next level function has been called")
	var next_level
	if current_level_number + 1 == max_number_levels:  # checks whether or not it's the last level, cycles back to title screen if it is
		current_level_number = -1
	next_level = load("res://stages/Level" + str(current_level_number + 1) + ".tscn").instance()
	level_container.add_child(next_level)
	next_level.connect("level_changed", self, "handle_next_level")
	current_level.queue_free()
	current_level = next_level

func _on_MenuButton_pressed():
	menu_screen.visible = not menu_screen.visible
