extends TileMap


var bright_texture = load("res://art/orangeDoorBright.png")
var dark_texture = load("res://art/orangeDoorDark.png")

var temp_time = 0

var plate_states = []

# Called when the node enters the scene tree for the first time.
func _ready():
	# Iterates over all the children of the door, which will only be its plates, and connects to their signals and adds their slot to plate_states array
	plate_states = []
	for plate in get_children():
		plate.connect("plate_change", self, "handle_plate_change")
		plate_states.append(false)


func handle_plate_change(plate_number, state):
	plate_states[plate_number - 1] = state
	check_states()
	
func check_states():
	var doors_up = true
	for state in plate_states:
		if state:
			doors_up = false
	if doors_up:
		tile_set.tile_set_texture(0, bright_texture)
		collision_layer = 16
	elif !doors_up:
		tile_set.tile_set_texture(0, dark_texture)
		collision_layer = 64
	
