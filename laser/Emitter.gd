extends StaticBody2D

var max_bounces = 25

onready var ray = $RayCast2D
onready var line = $Line2D

signal end_level

func _physics_process(delta):
	line.clear_points()
	
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		line.add_point(Vector2.ZERO)
		
		#define initial raycast
		ray.global_position = line.global_position
		ray.cast_to = (get_global_mouse_position()-line.global_position).normalized()*1000
		ray.force_raycast_update()
		
		var prev = null
		var bounces = 0
		
		while true:
			if not ray.is_colliding():
				var pt = ray.global_position + ray.cast_to
				line.add_point(line.to_local(pt))
				break
			
			var coll = ray.get_collider()
			var pt = ray.get_collision_point()
			
			line.add_point(line.to_local(pt))
			
			if coll.is_in_group("Recievers"):
				emit_signal("end_level")
			
			if not coll.is_in_group("Mirrors"):
				if not coll.is_in_group("Amplifiers"):
					break
			
			var normal  = ray.get_collision_normal()
			
			if normal == Vector2.ZERO:
				break
			
			
			
			#update collisions
			if prev != null:
				#layer stuff - uncomment on integration
				prev.collision_mask = 3
				prev.collision_layer = 3   #these will be adjusted for the actual layers
			prev = coll
			prev.collision_mask = 0
			prev.collision_layer = 0
			
			#update raycast
			if coll.is_in_group("Mirrors"):
				ray.global_position = pt
				ray.cast_to = ray.cast_to.bounce(normal)
				ray.force_raycast_update()
			elif coll.is_in_group("Amplifiers"):
				ray.global_position = coll.position
				ray.cast_to = coll.position + (Vector2(1000, 0).rotated(coll.rotation)) * 1000 - position
				ray.force_raycast_update()
			else:
				
				bounces += 1
				if bounces >= max_bounces:
					break
			
		if prev != null:
			prev.collision_mask = 3
			prev.collision_layer = 3










