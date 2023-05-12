extends Node

@onready var crowd_player = $CrowdPlayer
@onready var cheers_player = $CheersPlayer

var MAXWIDTH = Vector2(-25, 25)
var MAXHEIGTH = Vector2(-15, 10)

var Cheers_Audio = [preload("res://Audio/TheCrowd/cheers_1.ogg"), preload("res://Audio/TheCrowd/cheers_2.ogg"), preload("res://Audio/TheCrowd/cheers_3.ogg")]

var explosions = [preload("res://Scene/Explosions/Explosion.tscn")]


func Explosion_Start(pos):
	
	var exp_inst = explosions[0].instantiate()
	exp_inst.position = pos
	get_tree().get_root().add_child(exp_inst)


func Play_Cheers():
	if !cheers_player.playing:
		cheers_player.stream = Cheers_Audio[randi_range(0, Cheers_Audio.size()-1)]
