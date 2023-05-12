extends Node3D

func _ready():
	$Sprite3D/AnimationPlayer.play("explosions")
	await $Sprite3D/AnimationPlayer.animation_finished
	
	queue_free()


