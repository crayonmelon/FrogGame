extends CharacterBody3D

@onready var car_body = $"../CarBody"
@onready var carnoise = $"../CarBody/the car/carnoise"

const SPEED = 20
var FRICTION = 8
const MAX_SPEED = 20

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var rotation_direction = 0

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	car_body.rotation_degrees.y = snapped(rotation_degrees.y, 30)
	
	if velocity.length() > (FRICTION * delta):
		velocity -= velocity.normalized() * (FRICTION * delta)
	else:
		velocity = Vector3.ZERO
		
	# += direction of player
	velocity += -transform.basis.z * SPEED * delta
	velocity = velocity.limit_length(MAX_SPEED)
	
	look_at(get_tree().get_nodes_in_group("Frog")[0].global_position , Vector3.UP)
	
	carnoise.volume_db = rangeChange(abs(velocity.x), 10, 0, 0, -20)
	
	var cols = get_slide_collision(1)
	
	move_and_slide()
	screen_loop()
	
func rangeChange(OldValue, OldMax, OldMin, NewMax, NewMin):
	var OldRange = (OldMax - OldMin)  
	var NewRange = (NewMax - NewMin)  
	return (((OldValue - OldMin) * NewRange) / OldRange) + NewMin


func screen_loop():
	global_position.x = wrapf(global_position.x,-30, 30)
