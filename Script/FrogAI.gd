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
	
	var frogdie_inst = frogDie.instantiate()
	frogdie_inst.position = global_position
	
	get_tree().get_root().get_node("World").add_child(frogdie_inst)
	
	if get_parent().has_method("FrogDead"):
		get_parent().FrogDead(self)
		
	GLOBALS.cheers_player.play()
	
	queue_free()
