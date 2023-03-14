extends KinematicBody2D

export var rotation_speed = 1

export var gunload_time = 1

export var hp = 1

onready var player_detection_ray = $PlayerDetection

onready var bullet_prefab = load("res://Combat/bullet.tscn")

var player_found = false

var timestepper = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	player_detection_ray.exclude_parent = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !player_found: # function to sweep through searching for player
		rotation += rotation_speed * delta
		if player_detection_ray.get_collider() != null:  #  checks if the collider exists (in case of cracked walls, it deletes, which leaves no collider for the raycast to access)
			if player_detection_ray.is_colliding() && player_detection_ray.get_collider().get_collision_layer() == 1:  # HEAVY DEBUG NEEDED HERE - can't access get_collision_layer()
				player_found = true
				timestepper = 0
	if player_found:  # if the player is found, wait a certain amount of time
		timestepper += delta
		if timestepper < gunload_time:
			pass
		elif timestepper >= gunload_time:
			shoot()
			player_found = false

#  Creates the instance of a bullet
func shoot():
	var bullet = bullet_prefab.instance()
	bullet.position += position + Vector2(30,0).rotated(rotation)
	bullet.rotation = rotation
	get_parent().add_child(bullet)
	
#  Lowers the enemy's hp when shot
func _on_GSW_area_entered(area):
	if area.collision_layer == 8:
		hp -= 1
	if hp <= 0:
		queue_free()
