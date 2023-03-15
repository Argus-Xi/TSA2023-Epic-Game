extends StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#  Detects if it's hit by a bullet, disappears if it is
func _on_GSW_area_entered(area):
	if area.collision_layer == 8:
		queue_free()
