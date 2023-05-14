extends CanvasLayer

@onready var black = $Black
@onready var screen = $Screen

var tween : Tween
var tween_black : Tween
func Change_Scene(target,  last_scene)-> void:
	
	var img = get_viewport().get_texture().get_image()

	screen.texture = ImageTexture.create_from_image(img)
	
	get_tree().get_root().remove_child(last_scene)
	
	screen.scale = Vector2(1.0,1.0)
	screen.visible = true
	black.visible = true
	black.modulate.a = 0
	tween = create_tween() 
	tween.tween_property(screen,"scale", Vector2(100,100), 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.play()
	
	tween_black = create_tween() 
	tween_black.tween_property(black,"modulate:a", 1, 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween_black.play()
	
	await tween.finished
	screen.visible = false
	
	tween_black = create_tween() 
	tween_black.tween_property(black,"modulate:a", 0, .4).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween_black.play()
	
	get_tree().get_root().add_child(load(target).instantiate())
	
	
func Game_Over(frog, time, score, last_scene) -> void:
	
	var gameover_scene = load("res://Scene/GameOver.tscn").instantiate();
	
	gameover_scene.UpdateGameOver(frog, time, score)
	
	var img = get_viewport().get_texture().get_image()

	screen.texture = ImageTexture.create_from_image(img)
	
	get_tree().get_root().remove_child(last_scene)
	
	screen.scale = Vector2(1.0,1.0)
	screen.visible = true
	black.visible = true
	black.modulate.a = 0
	tween = create_tween() 
	tween.tween_property(screen,"scale", Vector2(100,100), 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.play()
	
	tween_black = create_tween() 
	tween_black.tween_property(black,"modulate:a", 1, 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween_black.play()
	
	await tween.finished
	screen.visible = false
	
	tween_black = create_tween() 
	tween_black.tween_property(black,"modulate:a", 0, .4).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween_black.play()
	
	get_tree().get_root().add_child(gameover_scene)
