extends CharacterBody3D

@onready var car_body = $"../CarBody"

const SPEED = 20
const JUMP_VELOCITY = 4.5
var FRICTION = 8
var orginal_friction = FRICTION
const BREAK_FORCE = 30
const MAX_SPEED = 20
var turnSpeed = 2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var rotation_direction = 0

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	if velocity.length() >= 0:
		rotation_direction = Input.get_axis("p2_right", "p2_left") * delta  * turnSpeed
	else:
		rotation_direction = 0
	
	if Input.is_action_pressed("p2_breaks"):
		FRICTION = BREAK_FORCE
	else:
		FRICTION = orginal_friction
	
	car_body.rotation_degrees.y = snapped(rotation_degrees.y, 2)
	
	if velocity.length() > (FRICTION * delta):
		velocity -= velocity.normalized() * (FRICTION * delta)
	else:
		velocity = Vector3.ZERO
		
	velocity += transform.basis.x * Input.get_axis("p2_up", "p2_down")  * SPEED * delta
	velocity = velocity.limit_length(MAX_SPEED)
	rotate_y(rotation_direction)
		
	move_and_slide()
