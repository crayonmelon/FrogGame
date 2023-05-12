extends CanvasLayer

func Change_Scene(target: String )-> void:
	get_tree().change_scene_to_file(target)
	
func Game_Over(frog, time, score, last_scene) -> void:
	
	var gameover_scene = load("res://Scene/GameOver.tscn").instantiate();
	
	gameover_scene.UpdateGameOver(frog, time, score)
	
	get_tree().get_root().add_child(gameover_scene)
	get_tree().get_root().remove_child(last_scene)
