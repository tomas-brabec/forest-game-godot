extends Node2D

var water_count = 0
var one = false
var one_complete = false
var two = false
var boost = 1

onready var player = get_node("../Player")

signal jump_boost(value)

func _ready() -> void:
	self.connect("jump_boost", player, "set_jump_boost")


func _on_Roots_area_entered(area: Area2D) -> void:
	water_count += 1
	if water_count > 12 and one == false:
		stage_1()
	elif water_count > 24 and two == false and one_complete == true:
		stage_2()


func stage_1():
	one = true
	$AnimationPlayer.play("Stage1")
	boost = 1.35
	if $Boost.overlaps_body(player):
		emit_signal("jump_boost", boost)


func stage_1_complete():
	one_complete = true


func stage_2():
	two = true
	$AnimationPlayer.play("Stage2")
	boost = 1.65
	if $Boost.overlaps_body(player):
		emit_signal("jump_boost", boost)



func _on_Boost_body_entered(body: Node) -> void:
	emit_signal("jump_boost", boost)


func _on_Boost_body_exited(body: Node) -> void:
	emit_signal("jump_boost", 1)
