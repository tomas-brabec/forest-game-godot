extends Node2D


onready var timer = $Timer
var Water = preload("res://Items/Water.tscn")

signal water_stop(index)

#func _ready() -> void:
#	$AnimationPlayer.play("Water")


func start_water() -> void:
	timer.start()
	emit_signal("water_stop", 0)


func stop_water() -> void:
	timer.stop()


func _on_Timer_timeout() -> void:
	var water = Water.instance()
	var x = rand_range(-4.0, 4.0)
	water.position = $Position2D.global_position + Vector2(x, 0)
	get_tree().current_scene.add_child(water)


func start_animation():
	$AnimationPlayer.play("Water")


func stop_animation():
	if $AnimationPlayer.is_playing():
		$AnimationPlayer.stop()
		$AnimationPlayer.seek(0, true)
		timer.stop()

func empty():
	$AnimationPlayer.play("Empty")
