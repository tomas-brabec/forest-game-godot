extends KinematicBody2D


const GRAV = 400

var velocity: Vector2 = Vector2.DOWN
var on_ground = false
var stage = 2
var water_count = 0

signal jump(stage)

func _ready() -> void:
	var player = get_node("../Player")
	connect("jump", player, "jump_signal")

func _on_Big_body_entered(body: Node) -> void:
	jump_maybe(body)


func _on_Small_body_entered(body: Node) -> void:
	jump_maybe(body)


func jump_maybe(body: Node) -> void:
	if body.has_method("is_in_jump") and body.is_in_jump():
		emit_signal("jump", stage)
		$AnimationPlayer.play("BigHead")
