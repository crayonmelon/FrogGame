extends Node3D

var frog = preload("res://Scene/Characters/FrogAI.tscn")

var frogs = []
@onready var spawn_areas = [$Spawn_Area_1, $Spawn_Area_2]


var kill_count = 0 
var spawn_amount = 1000

func _ready():
	SpawnFrog()

func SpawnFrog():
	
	$AnimationPlayer.play("CageOpen")
	await $AnimationPlayer.animation_finished

	var frog_inst = frog.instantiate()
	frog_inst.position = spawn_areas[randi_range(0, spawn_areas.size()-1)].global_position
	frogs.append(frog_inst)
	add_child(frog_inst)
	

	await get_tree().create_timer(.5).timeout
	$AnimationPlayer.play_backwards("CageOpen")
	
func FrogDead(frog):
	frogs.erase(frog)
	
	if frogs.is_empty():
		spawn_amount = spawn_amount * 4
		SpawnFrog()
		GLOBALS.Play_Cheers()
