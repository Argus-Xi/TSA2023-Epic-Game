extends Node

onready var level_container = $LevelContainer  # child that contains the levels below the UI of SceneSwitcher

onready var current_level = $LevelContainer/TitleScreen  # Initiates current_level variable with the Title Screen

onready var menu_screen = $MenuScreen  # menu screen UI reference

onready var solve_screen = $SolveScreen

onready var score_message = $SolveScreen/ScoreMessage

onready var die_screen = $DieScreen

onready var end_screen = $EndScreen

onready var final_score_message = $EndScreen/FinalScoreMessage

var level_scores = [0,0,0,0,0,0,0,0,0,0]

var final_score = 0

export var max_number_levels = 3   # Set number of levels to be cycled through (including Level0 or TitleScreen)

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
	die_screen.visible = false    # Same as solve screen above
	end_screen.visible = false
	
	# EndScreen trigger
	if current_level.level_number + 1 == max_number_levels:
		handle_end_screen()
		
func handle_end_screen():
	end_screen.visible = true
	final_score = final_score_sum()
	print(final_score)
	final_score_message.text = "Final Score: " + str(stepify(final_score, 0.01))
	
func final_score_sum():
	var sum = 0
	for score in level_scores:
		sum += score
	print(level_scores)
	print(sum)
	return sum
	
	

# Handles when the level is solved, displays the score, saves the score to the level_scores array for the final score
func handle_level_solved(score):
	solve_screen.visible = true
	score_message.text = "Score: " + str(stepify(score, 0.01))
	if score > level_scores[current_level.level_number - 1]:
		level_scores[current_level.level_number - 1] = score
	
#  Handles when one of the players die, signal from the level, asks to retry
func handle_player_death():
	die_screen.visible = true

# Pulls up menu screen
func _on_MenuButton_pressed():
	menu_screen.visible = not menu_screen.visible
	
	

#  FUNCTIONS FOR ALL BUTTONS IN SOLVE SCREEN

func _on_NextButtonMain_pressed():
	handle_next_level(current_level.level_number)

#  FUNCTIONS FOR ALL BUTTONS IN THE DIE SCREEN

func _on_RetryButton_pressed():
	handle_next_level(current_level.level_number - 1) # Retry button essentially moves to the next level, but pretends it was on the level before

#  FUNCTIONS FOR ALL BUTTONS IN END SCREEN

func _on_RestartGameButton_pressed():
	handle_next_level(current_level.level_number)


#  FUNCTIONS FOR ALL BUTTONS IN MENU SCREEN

func _on_TitleButton_pressed():
	handle_next_level(-1)
	menu_screen.visible = false
	
func _on_ReloadButton_pressed():
	handle_next_level(current_level.level_number - 1) # Reload button essentially moves to the next level, but pretends it was on the level before
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

func _on_ExitMenuButton_pressed():
	menu_screen.visible = false
