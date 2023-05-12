extends Area3D

@export var frogDie = preload("res://Scene/Characters/Frog_die.tscn")

func _ready():
	walk()

func walk():
	var tween = create_tween()
	tween.tween_property(self, "position", rand_Vector(20), randf_range(2,4))
	await tween.finished
	walk()
	
func rand_Vector(range):
	
	return Vector3(
		clamp(randi_range(global_position.x-range, global_position.x+range) ,GLOBALS.MAXWIDTH.x,GLOBALS.MAXWIDTH.y), 
		0,
		clamp(randi_range(global_position.y-range, global_position.y+range),GLOBALS.MAXHEIGTH.x,GLOBALS.MAXHEIGTH.y)
	)

func _on_body_entered(body):
	
	if body.has_method("Car_Die"):
		body.Car_Die()
