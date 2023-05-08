extends Node2D

var scenes = {
	"player_v_frog": "res://Scene/PlayerVSCar.tscn",
}

func _on_frogplayer_button_pressed():
	_Scene_Transistion.Change_Scene(scenes["player_v_frog"])
	pass # Replace with function body.
