extends Sprite


var right = true


func _physics_process(delta: float) -> void:
	if right:
		position += Vector2(0.4, 1) * 4
	else:
		position += Vector2(-0.4, 1) * 4

func set_dir(a: bool):
	right = a


func _on_Timer_timeout() -> void:
	queue_free()
