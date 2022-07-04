extends Area2D


var move: Vector2
const SPEED = 3


func _ready() -> void:
	var angel = rand_range(-0.4, -0.1)
	move = Vector2(0, 1).rotated(angel)


func _physics_process(delta: float) -> void:
	move = lerp(move, Vector2(0, 1), 0.02)
	position += move.normalized() * SPEED


func _on_Area2D_body_entered(body: Node) -> void:
	queue_free()


func _on_Timer_timeout() -> void:
	queue_free()
