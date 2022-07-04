extends Area2D


export(int, "Can", "Ball", "Mushroom", "Key", "Coin") var item_name

var item: TextureRect
var texture: Texture
var target: Vector2

onready var inventory = get_node("../CanvasLayer/Inventory")
onready var player = $AnimationPlayer

func _ready() -> void:
	load_item()
	$Sprite.texture = texture
	item = TextureRect.new()
	item.set_texture(texture)
	item.set_scale(Vector2(0.25, 0.25))
	

func _on_CollectibleItem_body_entered(body: Node) -> void:
	inventory.add_item(item_name)
	$AudioStreamPlayer.play()
	var tween = Tween.new()
	var position = get_global_transform_with_canvas().origin
	item.rect_position = position + Vector2(-20, -20)
	tween.interpolate_property(item, "rect_position", item.rect_position, target, 1.0, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	item.add_child(tween)
	$Sprite.visible = false
	$CollisionShape2D.set_deferred("disabled", true)
	get_node("../CanvasLayer").add_child(item)
	tween.connect("tween_completed", self, "end_this")
	tween.start()


func load_item() -> void:
	match item_name:
		0: 
			texture = load("res://Images/watering_can.png")
			target = Vector2(15, 15)
		1:
			texture = load("res://Images/ball.png")
			target = Vector2(75, 15)
		2:
			texture = load("res://Images/mushroom.png")
			target = Vector2(135, 15)
		3:
			texture = load("res://Images/key.png")
			target = Vector2(195, 15)
		4:
			texture = load("res://Images/coin.png")
			target = Vector2(1225, 15)


func end_this(a, b):
#	inventory.add_item(item_name)
	item.queue_free()
	self.queue_free()
