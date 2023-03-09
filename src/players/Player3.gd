extends Node2D

export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

func _ready(): 
	screen_size = get_viewport_rect().size

func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("p3_right"):
		velocity.x += 1
	if Input.is_action_pressed("p3_left"):
		velocity.x -= 1
	if Input.is_action_pressed("p3_down"):
		velocity.y += 1
	if Input.is_action_pressed("p3_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)



# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass