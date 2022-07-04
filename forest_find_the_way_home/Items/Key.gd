extends Area2D


var move = Vector2.LEFT
var inventory

signal change(index, value)

func _ready() -> void:
	var inventory = get_node("../CanvasLayer/Inventory")
	connect("change", inventory, "set_count")
	emit_signal("change", 3, -1)


func set_vector(pos: Vector2, target: Vector2) -> void:
	pos += Vector2(0, -120)
	var angle = pos.angle_to_point(target)
	var deg = rad2deg(angle)
	if deg < 90 and deg > -90:
		$Sprite.flip_v = true
	move = move.rotated(angle)
	move = move.normalized()
	self.global_position = pos
	self.rotate(angle)
	


func _physics_process(delta: float) -> void:
	position += move * 6


func _on_Key_body_entered(body: Node) -> void:
	if body.has_method("open_wall"):
		var pos = $Position2D.global_position
		body.open_wall(pos)
		queue_free()
	else:
		emit_signal("change", 3, 1)
		queue_free()


func _on_Timer_timeout() -> void:
	emit_signal("change", 3, 1)
	queue_free()
