extends Sprite2D

var can_fire = true
var bullet = preload("res://bullet/bullet.tscn")
@export var target_rotation = 0.0
@export var follow_speed = 0.08
var max_rotation = deg_to_rad(90)

func _process(_delta):
	if $"../Character Sprite".flip_h == true:
		flip_v = true
		position.x = -3
	else:
		flip_v = false
		position.x = 3
	var mouse_pos = get_global_mouse_position()
	var target_direction = (mouse_pos - global_position).normalized()
	target_rotation = atan2(target_direction.y, target_direction.x)

	# Calculate the angle difference and ensure it's within the range of -π to π
	var angle_difference = target_rotation - rotation
	if angle_difference > PI:
		angle_difference -= 2 * PI
	if angle_difference < -PI:
		angle_difference += 2 * PI

	rotation += angle_difference * follow_speed
	
	if Input.is_action_pressed("shoot2") and can_fire and $"..".isRunning == false:
#	if Input.is_action_just_pressed("shoot") and can_fire and $"..".isRunning == false:
		var bullet_instance = bullet.instantiate()
		bullet_instance.rotation = rotation + randf_range(-0.15, 0.15)
		bullet_instance.global_position = $muzzle.global_position
		get_parent().add_child(bullet_instance)
		can_fire = false
		await get_tree().create_timer(0.005).timeout
		can_fire = true
