extends RigidBody3D
@onready var crate_mesh = $"../Crate_Mesh"

@export var Strength = 500

func Collision_With_Car(direction):
	
	apply_central_impulse(((Vector3.UP*4) + direction) * Strength * get_process_delta_time())
	apply_torque(direction)

func _physics_process(delta):
	crate_mesh.rotation_degrees.x = snapped(rotation_degrees.x, 30)
	crate_mesh.rotation_degrees.y = snapped(rotation_degrees.y, 30)
	crate_mesh.rotation_degrees.z = snapped(rotation_degrees.z, 30)
	
