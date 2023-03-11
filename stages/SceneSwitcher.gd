extends Node

onready var level_container = $LevelContainer  # child that contains the levels below the UI of SceneSwitcher

onready var current_level = $LevelContainer/TitleScreen  # Initiates current_level variable with the Title Screen

onready var menu_screen = $MenuScreen  # menu screen UI reference

onready var solve_screen = $SolveScreen

var max_number_levels = 3   # Set number of levels to be cycled through (including Level0 or TitleScreen)

func _ready() -> void:
	current_level.connect("level_changed", self, "handle_next_level")
	current_level.connect("level_solved", self, "handle_level_solved")
	current_level.connect("player_died", self, "handle_player_death")

func handle_next_level(current_level_number: int):
	var next_level
	if current_level_number + 1 >= max_number_levels:  # checks whether or not it's the last level, cycles back to title screen if it is
		current_level_number = -1
	next_level = load("res://stages/Level" + str(current_level_number + 1) + ".tscn").instance()
	level_container.add_child(next_level)
	next_level.connect("level_changed", self, "handle_next_level")
	next_level.connect("level_solved", self, "handle_level_solved")
	next_level.connect("player_died", self, "handle_player_death")
	current_level.queue_free()
	current_level = next_level
	solve_screen.visible = false   # After a level is solved and "next" button is pressed, the solve screen should disappear

func handle_level_solved():
	solve_screen.visible = true
	
func handle_player_death():
	print(current_level.level_number)

# Pulls up menu screen
func _on_MenuButton_pressed():
	menu_screen.visible = not menu_screen.visible


#  FUNCTIONS FOR ALL BUTTONS IN MENU SCREEN

func _on_TitleButton_pressed():
	handle_next_level(-1)
	menu_screen.visible = false

func _on_Level1Button_pressed():
	handle_next_level(0)
	menu_screen.visible = false

func _on_Level2Button_pressed():
	handle_next_level(1)
	menu_screen.visible = false

func _on_Level3Button_pressed():
	handle_next_level(2)
	menu_screen.visible = false

func _on_Level4Button_pressed():
	handle_next_level(3)
	menu_screen.visible = false

func _on_Level5Button_pressed():
	handle_next_level(4)
	menu_screen.visible = false

func _on_Level6Button_pressed():
	handle_next_level(5)
	menu_screen.visible = false

func _on_Level7Button_pressed():
	handle_next_level(6)
	menu_screen.visible = false

func _on_Level8Button_pressed():
	handle_next_level(7)
	menu_screen.visible = false

func _on_Level9Button_pressed():
	handle_next_level(8)
	menu_screen.visible = false

func _on_Level10Button_pressed():
	handle_next_level(9)
	menu_screen.visible = false
