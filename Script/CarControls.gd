extends CharacterBody3D

@onready var car_body = $"../CarBody"
@onready var carnoise = $"../CarBody/the car/carnoise"
var car_dead = preload("res://Scene/Characters/car_dead.tscn")

const SPEED = 20
const JUMP_VELOCITY = 4.5
var FRICTION = 8
var orginal_friction = FRICTION
const BREAK_FORCE = 30
const MAX_SPEED = 20
var turnSpeed = 2

@export var is_multiplayer = false

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
		rotation_direction = Input.get_axis("p2_right" if is_multiplayer else "right", "p2_left" if is_multiplayer else "left") * delta  * turnSpeed
	else:
		rotation_direction = 0
	
	if Input.is_action_pressed("p2_breaks"):
		FRICTION = BREAK_FORCE
	else:
		FRICTION = orginal_friction
	
	car_body.rotation_degrees.y = snapped(rotation_degrees.y, 30)
	
	if velocity.length() > (FRICTION * delta):
		velocity -= velocity.normalized() * (FRICTION * delta)
	else:
		velocity = Vector3.ZERO
		
	velocity += transform.basis.x * Input.get_axis("p2_up" if is_multiplayer else "up", "p2_down" if is_multiplayer else "down")  * SPEED * delta
	velocity = velocity.limit_length(MAX_SPEED)
	rotate_y(rotation_direction)
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().has_method("Collision_With_Car"):
			collision.get_collider().Collision_With_Car((collision.get_collider().global_position - global_position) + Vector3.UP)
			
	carnoise.volume_db = rangeChange(abs(velocity.x), 10, 0, 0, -20)
	move_and_slide()
	screen_loop()
	
func rangeChange(OldValue, OldMax, OldMin, NewMax, NewMin):
	var OldRange = (OldMax - OldMin)  
	var NewRange = (NewMax - NewMin)  
	return (((OldValue - OldMin) * NewRange) / OldRange) + NewMin

func screen_loop():
	position.x = wrapf(position.x,-30, 30)

func Car_Die():
	var car_died_inst = car_dead.instantiate()
	car_died_inst.position = global_position
	car_died_inst.rotation = global_rotation
	
	get_tree().get_root().add_child(car_died_inst)
	
	car_body.queue_free()
	queue_free()
