extends KinematicBody2D


const GRAV = 400

var velocity: Vector2 = Vector2.DOWN
var on_ground = false
var stage = 1
var water_count = 0

signal change(index, value)
signal jump(stage)

func _ready() -> void:
	var inventory = get_node("../CanvasLayer/Inventory")
	var player = get_node("../Player")
	connect("change", inventory, "set_count")
	connect("jump", player, "jump_signal")
	emit_signal("change", 2, -1)


func _physics_process(delta: float) -> void:
	if is_on_floor():
		pass
	else:
#		velocity.x = lerp(velocity.x, 0, AIR_FRIC)	
		velocity.y += GRAV * delta
		
		velocity = move_and_slide(velocity, Vector2.UP)


func _on_Timer_timeout() -> void:
	if not is_on_floor():
		emit_signal("change", 2, 1)
		queue_free()


func _on_Big_body_entered(body: Node) -> void:
	jump_maybe(body)


func _on_Small_body_entered(body: Node) -> void:
	jump_maybe(body)


func jump_maybe(body: Node) -> void:
	if body.has_method("is_in_jump") and body.is_in_jump():
		emit_signal("jump", stage)
		match stage:
			1:
				$AnimationPlayer.play("Head")
			2:
				$AnimationPlayer.play("BigHead")


func _on_Roots_area_entered(area: Area2D) -> void:
	water_count += 1
	if water_count > 12:
		stage = 2
		$Head.visible = false
		$Small/CollisionShape2D.set_deferred("disabled", true)
		$BigHead.visible = true
		$Big/CollisionShape2D.set_deferred("disabled", false)


func set_vector(pos: Vector2, target: Vector2) -> void:
	velocity = Vector2.LEFT
	pos += Vector2(0, -120)
	global_position = pos
	var angle = pos.angle_to_point(target)
	velocity = velocity.rotated(angle)
	velocity = velocity.normalized()
	velocity *= 320
