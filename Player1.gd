extends Node2D

export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.
export (float) var rotation_speed = 1.5

func _ready(): 
	screen_size = get_viewport_rect().size

var velocity = Vector2()
var rotation_dir = 0

func get_input():
	rotation_dir = 0
	velocity = Vector2()
	if Input.is_action_pressed("p1_right"):
		rotation_dir += 1
	if Input.is_action_pressed("p1_left"):
		rotation_dir -= 1
	if Input.is_action_pressed("p1_down"):
		velocity = Vector2(-speed, 0).rotated(rotation)
	if Input.is_action_pressed("p1_up"):
		velocity = Vector2(speed, 0).rotated(rotation)

func _physics_process(delta):
	get_input()
	rotation += rotation_dir * rotation_speed * delta

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	#	$AnimatedSprite.play()
	#else:
	#	$AnimatedSprite.stop()
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
