extends Sprite


export(int, "Ball", "Mushroom", "Key") var item_name

onready var player = $AnimationPlayer
var Key = preload("res://Items/Key.tscn")
var Mushroom = preload("res://Items/Mushroom.tscn")
var Ball = preload("res://Items/Ball.tscn")

func _ready() -> void:
	match item_name:
		0:
			texture = load("res://Images/ball.png")
		1:
			texture = load("res://Images/mushroom.png")
		2:
			texture = load("res://Images/key.png")


func fire(pos: Vector2, target: Vector2) -> void:
	match item_name:
		0:
			fire_ball(pos, target)
		1:
			fire_mushroom(pos, target)
		2:
			fire_key(pos, target)


func empty():
	player.play("Empty")


func fire_key(pos: Vector2, target: Vector2) -> void:
	var key = Key.instance()
	key.set_vector(pos, target)
	get_tree().current_scene.add_child(key)


func fire_mushroom(pos: Vector2, target: Vector2) -> void:
	var mushroom = Mushroom.instance()
	mushroom.set_vector(pos, target)
	get_tree().current_scene.add_child(mushroom)


func fire_ball(pos: Vector2, target: Vector2) -> void:
	var ball = Ball.instance()
	ball.set_vector(pos, target)
	get_tree().current_scene.add_child(ball)
