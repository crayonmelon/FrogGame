extends Node2D

var scenes = {
	"player_v_car": "res://Scene/PlayerVSCar.tscn",
	"player_v_frog" : "res://Scene/PlayerVSFrog.tscn",
	"two_player" : "res://Scene/TwoPlayer.tscn"
}

func _on_frogplayer_button_pressed():
	_Scene_Transistion.Change_Scene(scenes["player_v_frog"])

func _on_car_player_button_pressed():
	_Scene_Transistion.Change_Scene(scenes["player_v_car"])

func _on_2_player_button_pressed():
	_Scene_Transistion.Change_Scene(scenes["two_player"])
