extends RigidBody3D

func _ready():
	
	Die()
	await get_tree().create_timer(.5).timeout
	GLOBALS.Explosion_Start(self.global_position)
	await get_tree().create_timer(.5).timeout
	
	$"..".queue_free()
	_Scene_Transistion.Change_Scene("res://Scene/GameOver.tscn")
	
func Die():
	apply_central_force(Vector3(1,1,1)*1000)
	apply_torque(Vector3(1,1,1)*1000)
	
