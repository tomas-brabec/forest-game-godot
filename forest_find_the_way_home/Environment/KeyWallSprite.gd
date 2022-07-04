extends Node2D


func _ready() -> void:
	$AnimationPlayer.play("Break")


func end() -> void:
	queue_free()
