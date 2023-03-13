extends Node2D

signal level_changed

signal level_solved

signal player_died

export var level_number = 0

var level_running = true

var level_time = 0

var score = 0

func _ready():
	
	#  connects the level to the players' death signals, three of the 4 determinants of the level outcome, last being solved transferred from the laser receptor
	$Player1.connect("player_death", self, "died")
	$player2.connect("player_death", self, "died")
	$player3.connect("player_death", self, "died")
	
	#  connects the level to the emitter's "end_level" signal to know when to end the level
	$Emitter.connect("end_level", self, "solved")

func _process(delta):
	if level_running == true:
		level_time += delta
		$TimeLabel.text = str(stepify(level_time, 0.01))


# This is redundant because the main screen will have a button in the solve screen, but that's okay
func _on_NextButton_pressed():
	emit_signal("level_changed", level_number)

#  Functions to send level events up to SceneSwitcher

func solved():   # Calculates the score and sends it to the SceneSwitcher for the UI
	score = 300 - level_time   # 300 represents a max signal strength multiplied by some constant as a y-intercept  for the score
	if score < 100:
		score = 100
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
