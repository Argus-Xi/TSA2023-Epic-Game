extends KinematicBody2D

signal player_death

onready var bullet_prefab = load("res://Combat/bullet.tscn")

export var speed = 400 # How fast the player will move (pixels/sec).
export var hp = 2 # How many lives the player has
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
	if Input.is_action_just_pressed("p1_shoot"):
		shoot()
		
#  Creates the instance of a bullet
func shoot():
	var bullet = bullet_prefab.instance()
	bullet.position += position + Vector2(30,0).rotated(rotation)
	bullet.rotation = rotation
	get_parent().add_child(bullet)

func _physics_process(delta):
	get_input()
	# rotates the player
	rotation += rotation_dir * rotation_speed * delta

	# normalizes the velocity's direction and multiplying it by the speed and the time passed between frames
	velocity = velocity.normalized() * speed

	move_and_slide(velocity)
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

#  Detects if the player's been hit
func _on_GSW_area_entered(area):
	if area.collision_layer == 8:
		hp -= 1
	if hp <= 0:
		emit_signal("player_death")
		queue_free()
