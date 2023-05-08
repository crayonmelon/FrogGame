extends CanvasLayer


func Change_Scene(target: String )-> void:
	get_tree().change_scene_to_file(target)
