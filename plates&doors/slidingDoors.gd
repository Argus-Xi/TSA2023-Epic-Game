extends TileMap


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
		# Goes through each of the tiles in an array of all the tiles, which are also arrays apparently, and gets their position and sets their tile ID to a new tile with that tile ID, so in the tileset, it'll need the 0 and 1 tile ID's
		for tile in get_used_cells():
			set_cell(tile[0], tile[1], 0)
		set_collision_layer(16)
	elif !doors_up:
		# Same as comment above
		for tile in get_used_cells():
			set_cell(tile[0], tile[1], 1)
		set_collision_layer(64)
