extends Node3D

var frog = preload("res://Scene/Characters/FrogAI.tscn")
var bigFrog = preload("res://Scene/Characters/FrogAI.tscn")

var frogs = []
@onready var timer = $Timer
@onready var spawn_areas = [$Spawn_Area_1, $Spawn_Area_2]
@onready var timer_label = $SubViewport/Label

var kill_count = 0 
var spawn_amount = 1

func _ready():
	SpawnFrog()

func _process(delta):
	timer_label.text = str(timer.time_left).pad_decimals(2) 

func SpawnFrog():
	
	$AnimationPlayer.play("CageOpen")
	await $AnimationPlayer.animation_finished
	
	for i in range(spawn_amount):
		var frog_inst = frog.instantiate()
		frog_inst.position = spawn_areas[randi_range(0, spawn_areas.size()-1)].global_position
		frogs.append(frog_inst)
		add_child(frog_inst)
	
	if spawn_amount > 10:
		var big_frog_inst = bigFrog.instantiate()
		big_frog_inst.position = spawn_areas[randi_range(0, spawn_areas.size()-1)].global_position
		add_child(big_frog_inst)
	
	await get_tree().create_timer(.5).timeout
	$AnimationPlayer.play_backwards("CageOpen")
	
func FrogDead(frog):
	kill_count += 1
	frogs.erase(frog)
	
	if frogs.is_empty():
		spawn_amount = spawn_amount * 4
		SpawnFrog()

func _on_timer_timeout():
	#SMELLY CODE
	_Scene_Transistion.Game_Over(true, 0, spawn_amount, $"..")
