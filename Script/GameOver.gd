extends Node2D
@onready var score_text = $Score

var frogMode = false
var time
var score

func _ready():
	GameOver()

func GameOver():
	
	if frogMode:
		score_text.text = "CASUALTIES:
		" + str(score)
	else: 
		score_text.text = "TIME
		" + str(time)
	
func UpdateGameOver(frogMode, time, score):
	self.frogMode = frogMode
	self.time = time
	self.score = score
	

func _on_main_menu_button_pressed():
	_Scene_Transistion.Change_Scene("res://Scene/MainMenu.tscn")
	queue_free()
