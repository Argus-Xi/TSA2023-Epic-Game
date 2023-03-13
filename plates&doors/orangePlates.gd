extends Area2D

signal plate_change

export var plate_number = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(_delta):
	hard_colliding_check()


func hard_colliding_check():
	# All of this loops through the colliders of the plate and checks if any of them are players or enemies. If they are, it says it was pressed. If they aren't, it says it's not being pressed
	if len(get_overlapping_bodies()) == 0: # If there's no overlapping bodies, signal the plate state as false
		emit_signal("plate_change", plate_number, false)
	elif len(get_overlapping_bodies()) > 0: # If there's overlapping bodies, go through each one, check if any of them are players or enemies, and if they are, send state as true. If they aren't, send state as false
		var being_pressed = false
		for collider in get_overlapping_bodies():
			if collider.collision_layer == 1 or collider.collision_layer == 2:
				being_pressed = true
			else:
				pass
		if !being_pressed:
			emit_signal("plate_change", plate_number, false)
		elif being_pressed:
			emit_signal("plate_change", plate_number, true)
