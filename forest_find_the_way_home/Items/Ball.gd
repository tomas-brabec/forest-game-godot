extends RigidBody2D


var impuls = Vector2.LEFT
var touch = false

signal change(index, value)

func _ready() -> void:
	var inventory = get_node("../CanvasLayer/Inventory")
	connect("change", inventory, "set_count")
	emit_signal("change", 1, -1)


func set_vector(pos: Vector2, target: Vector2) -> void:
	pos += Vector2(0, -120)
	global_position = pos
	var angle = pos.angle_to_point(target)
	impuls = impuls.rotated(angle)
	impuls = impuls.normalized()
	impuls *= 320


func _on_Timer_timeout() -> void:
	apply_impulse(Vector2(0, -10), impuls)


func _on_Ball_body_entered(body: Node) -> void:
	if body.is_in_group("Wall") and not touch:
		touch = true
		$Timer2.stop()
		$Timer2.start(2)
	elif body.has_method("kill_enemy"):
		body.kill_enemy()
	


func _on_Timer2_timeout() -> void:
	queue_free()
