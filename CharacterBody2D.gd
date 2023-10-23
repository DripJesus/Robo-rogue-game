extends CharacterBody2D
class_name TankEnemy

var scrap = preload("res://Scrap Counter/scrap.tscn")
var scrap_spawned = false

var health = 100 

func on_hit(dmg):
	health -= dmg
	if health <= 0:
		queue_free()
		if scrap_spawned == false:
			print ("scrap spawn")
			var scrap_instance = scrap.instantiate()
			scrap_instance.global_position = global_position
			get_tree().root.add_child(scrap_instance)
			scrap_spawned = true

func _process(_delta):
	pass

func _physics_process(_delta):
	move_and_slide()

	if velocity.length() > 0:
		pass
		
	if velocity.x > 0:
		$Sprite2D2.flip_h = true
	else:
		$Sprite2D2.flip_h = false
		


