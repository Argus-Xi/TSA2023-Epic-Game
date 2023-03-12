extends Area2D


export var speed = 300

var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2(speed,0).rotated(rotation)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = Vector2(speed,0).rotated(rotation)
	position += velocity * delta
	if Vector2(position.x,position.y).length() > 5000:
		queue_free()


#  Using the boolean dead_bullet rather than immediately queue_free() gives the player or enemy time to detect the collision
func _on_Area2D_body_entered(body):
	queue_free()
