extends Node

@onready var crowd_player = $CrowdPlayer
@onready var cheers_player = $CheersPlayer
@onready var announcers_player = $AnnouncersPlayer
@onready var announcer_rand = $Announcer_rand

var MAXWIDTH = Vector2(-25, 25)
var MAXHEIGTH = Vector2(-15, 10)

var Cheers_Audio = [preload("res://Audio/TheCrowd/cheers_1.ogg"), preload("res://Audio/TheCrowd/cheers_2.ogg"), preload("res://Audio/TheCrowd/cheers_3.ogg")]

var announcer_index = 0
var announcer_Audio = [preload("res://Audio/announcers/bigFrog.ogg"), preload("res://Audio/announcers/buycameras.ogg"), preload("res://Audio/announcers/CarThroughThem.ogg"), preload("res://Audio/announcers/CarWin.ogg"), preload("res://Audio/announcers/courtsummings.ogg"), preload("res://Audio/announcers/emails.ogg"), preload("res://Audio/announcers/ford.ogg"), preload("res://Audio/announcers/forgotname.ogg"), preload("res://Audio/announcers/french.ogg"), preload("res://Audio/announcers/frog is dead.ogg"), preload("res://Audio/announcers/frogInTrout.ogg"), preload("res://Audio/announcers/FrogStompStatium.ogg"), preload("res://Audio/announcers/I Think THe frogs have this one John.ogg"), preload("res://Audio/announcers/intoFocus.ogg"), preload("res://Audio/announcers/ohno.ogg"), preload("res://Audio/announcers/peta.ogg"), preload("res://Audio/announcers/PlaceInHell.ogg"), preload("res://Audio/announcers/staydown.ogg"), preload("res://Audio/announcers/what else is there to say.ogg")]
var explosions = [preload("res://Scene/Explosions/Explosion.tscn")]

func _ready():
	announcer_Audio.shuffle()

func Explosion_Start(pos):
	
	var exp_inst = explosions[0].instantiate()
	exp_inst.position = pos
	get_tree().get_root().add_child(exp_inst)

func Play_Cheers():
	if !cheers_player.playing:
		cheers_player.stream = Cheers_Audio[randi_range(0, Cheers_Audio.size()-1)]
		cheers_player.play()

var lastAudio = -1
func Play_Rand_Announcer():
	if !announcers_player.playing:
		
		if announcer_index >= announcer_Audio.size():
			announcer_index = 0
			announcer_Audio.shuffle()
		
		announcers_player.stream = announcer_Audio[announcer_index]
		announcers_player.play()
		
		announcer_index += 1
	
func _on_announcer_rand_timeout():
	Play_Rand_Announcer()
	announcer_rand.start(10)
	


var paused = false

func _input(event):
	if event.is_action_pressed("pause"):
		
		if !paused:
			add_child(preload("res://Scene/settings.tscn").instantiate())
			paused = true
		else: 
			get_node("settings").queue_free()
			paused = false
