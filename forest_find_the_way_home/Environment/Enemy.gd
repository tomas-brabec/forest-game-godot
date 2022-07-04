extends KinematicBody2D


onready var edge: RayCast2D = $Edge
onready var front: RayCast2D = $Front
onready var front_player: RayCast2D = $FrontPlayer

var velocity = Vector2.RIGHT
const SPEED = 200
const SPEED_BOST = 480
const GRAV = 740
var right = true

var inventory
var Coin = preload("res://Items/CoinOut.tscn")
var kill = false
var jump = false

signal player(value)
signal coin(index)

func _ready() -> void:
	$AnimationPlayer.play("Run")
	var player = get_node("../Player")
	inventory = get_node("../CanvasLayer/Inventory")
	connect("player", player, "jump_signal")
	connect("coin", inventory, "update_count")


func _physics_process(delta: float) -> void:
	if not kill:
		if front.is_colliding():
			right = !right
			flip_rays()
		elif not edge.is_colliding():
			right = !right
			flip_rays()
		
		if right:
			velocity = Vector2.RIGHT
		else:
			velocity = Vector2.LEFT
		
		if front_player.is_colliding():
			velocity *= SPEED_BOST
		else:
			velocity *= SPEED
	
	if jump:
		velocity = Vector2.UP * SPEED_BOST
		jump = false
		edge.enabled = false
		front.enabled = false
		front_player.enabled = false
		set_collision_mask_bit(0, false)
		set_collision_mask_bit(4, false)
	
	velocity.y += GRAV * delta
	
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	$Sprite.flip_h = !right


func flip_rays():
	if right:
		edge.position = Vector2(40, 0)
		front.cast_to = Vector2(40, 0)
		front_player.cast_to = Vector2(400, 0)
		$Area2D/CollisionShape2D.position = Vector2(27, -7)
	else:
		edge.position = Vector2(-40, 0)
		front.cast_to = Vector2(-40, 0)
		front_player.cast_to = Vector2(-400, 0)
		$Area2D/CollisionShape2D.position = Vector2(-27, -7)


func _on_Area2D_body_entered(body: Node) -> void:
	$AudioStreamPlayer.play()
	emit_signal("player", 1)
	if inventory.get_count(4) > 0:
		emit_signal("coin", 4)
		var coin = Coin.instance()
		coin.set_dir(right)
		if right:
			coin.global_position = global_position + Vector2(50, -40)
		else:
			coin.global_position = global_position + Vector2(-50, -40)
		get_tree().current_scene.add_child(coin)

func kill_enemy():
	kill = true
	jump = true
	$Timer.start()
	$Area2D/CollisionShape2D.set_deferred("disabled", true)


func _on_Timer_timeout() -> void:
	queue_free()
