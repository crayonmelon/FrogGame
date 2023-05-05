extends CharacterBody3D

@onready var car_body = $"../CarBody"

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

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
	
	if Input.is_action_pressed("p2_up") or Input.is_action_pressed("p2_down"):
		rotation_direction = Input.get_axis("p2_right", "p2_left") * delta
	else:
		rotation_direction = 0
	
	car_body.rotation_degrees.y = snapped(rotation_degrees.y, 2)
	
	velocity = transform.basis.x * Input.get_axis("p2_up", "p2_down")  * SPEED
	
	rotate_y(rotation_direction)
		
	move_and_slide()
