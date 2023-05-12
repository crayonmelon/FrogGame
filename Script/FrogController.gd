extends CharacterBody3D

var WALK = 10
const SPRINT = 20
var speed = WALK
const JUMP_VELOCITY = 4.5

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir = Input.get_vector("right", "left", "down", "up")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if Input.is_action_pressed("sprint"):
		speed = SPRINT
	else:
		speed = WALK
	
	
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		$Sprite3D/AnimationPlayer.play("walk")
		
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
		$Sprite3D/AnimationPlayer.play("idle")
	move_and_slide()
	
	screen_loop()
	
func screen_loop():
	position.x = wrapf(position.x,-30, 30)
