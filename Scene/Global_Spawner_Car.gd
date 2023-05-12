extends Node3D

var carAI = preload("res://Scene/Characters/carAI.tscn")
var time = 0
var timer_on = false
@onready var timer = $Timer
var spawn_amount = 1
@onready var label = $SubViewport/Label
@onready var spawn_areas = [$Spawn_Area_1, $Spawn_Area_2]
func _ready():
	timer_on = true
	SpawnInCar()
	pass 

func _process(delta):
	if (timer_on):
		time+= delta
	label.text = str(time).pad_decimals(2) 
	
func SpawnInCar():
	
	$AnimationPlayer.play("CageOpen")
	await $AnimationPlayer.animation_finished
	
	var car_inst = carAI.instantiate()
	car_inst.position = spawn_areas[randi_range(0, spawn_areas.size()-1)].global_position
	add_child(car_inst)

	$AnimationPlayer.play_backwards("CageOpen")


func Game_Over():
	_Scene_Transistion.Game_Over(false, time, 0, $"..")
	pass


func _on_timer_timeout():
	if spawn_amount < 12:
		timer.start(15)
		
	SpawnInCar()
	spawn_amount+=1
