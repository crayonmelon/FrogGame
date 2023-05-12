extends Node

var MAXWIDTH = Vector2(-25, 25)
var MAXHEIGTH = Vector2(-15, 10)

var explosions = [preload("res://Scene/Explosions/Explosion.tscn")]

func Explosion_Start(pos):
	
	var exp_inst = explosions[0].instantiate()
	exp_inst.position = pos
	get_tree().get_root().add_child(exp_inst)
