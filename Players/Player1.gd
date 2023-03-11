extends KinematicBody2D

export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.
export (float) var rotation_speed = 1.5

func _ready(): 
	screen_size = get_viewport_rect().size

#  Where the body will move
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
		velocity = Vector2(-1, 0).rotated(rotation)
	if Input.is_action_pressed("p1_up"):
		velocity = Vector2(1, 0).rotated(rotation)

func _physics_process(delta):
	get_input()
	# rotates the player
	rotation += rotation_dir * rotation_speed * delta

	# normalizes the velocity's direction and multiplying it by the speed and the time passed between frames
	velocity = velocity.normalized() * speed * delta

	move_and_collide(velocity)
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
