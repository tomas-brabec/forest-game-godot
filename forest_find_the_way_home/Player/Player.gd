extends KinematicBody2D


onready var eye_left: Sprite = $player_eye as Sprite
onready var eye_right: Sprite = $player_eye2 as Sprite
onready var player: AnimationTree = $AnimationTree as AnimationTree
onready var anim_state: AnimationNodeStateMachinePlayback = player.get("parameters/playback") as AnimationNodeStateMachinePlayback
onready var can = $WateringCan
onready var ball = $ItemIcon
onready var mushroom = $ItemIcon2
onready var key = $ItemIcon3
onready var inventory = get_node("../CanvasLayer/Inventory")

var look_right: bool = true
var action_ready: bool = false

var velocity: Vector2 = Vector2.ZERO

const ACCEL = 1000
const SPEED = 380
const FRIC = 0.2
const AIR_FRIC = 0.01
const GRAV = 740
const JUMP = 460

var selected_item = 0
var jump_boost: float = 1


func _ready() -> void:
	randomize()
	player.active = true
	inventory.connect("selecion_change", self, "selection_change")
	can.connect("water_stop", inventory, "update_count")


func selection_change(index: int) -> void:
	selected_item = index


func _process(delta: float) -> void:
	look_at_mouse_positon()


func look_at_mouse_positon() -> void:
	var mouse_position: Vector2 = get_global_mouse_position()
	eye_left.look_at(mouse_position)
	eye_right.look_at(mouse_position)


func _physics_process(delta: float) -> void:
	var move_input: float = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var animation: String = "Idle"
	
	if move_input != 0:
		run(move_input, delta)
	else:
		stands()
	
	if Input.is_action_just_pressed("ready"):
		action_ready = !action_ready
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y -= JUMP * jump_boost
	
	if not is_on_floor():
		action_ready = false
		anim_state.travel("Jump")
	
	velocity.y += GRAV * delta
	
	velocity = move_and_slide(velocity, Vector2.UP)
	$player_body.flip_h = not look_right
	
	if action_ready:
		action()
		if Input.is_action_just_pressed("fire"):
			fire(get_global_mouse_position())
	else:
		can.visible = false
		can.stop_animation()
		ball.visible = false
		mushroom.visible = false
		key.visible = false


func set_jump_boost(value):
	jump_boost = value


func action():
	can.visible = false
	ball.visible = false
	mushroom.visible = false
	key.visible = false
	match selected_item:
		0:
			can.visible = true
		1: 
			ball.visible = true
		2: 
			mushroom.visible = true
		3: 
			key.visible = true


func fire(target: Vector2):
	var pos = global_position
	var count = inventory.get_count(selected_item)
	match selected_item:
		0:
			if count > 0:
				can.start_animation()
			else:
				can.empty()
		1:
			if count > 0:
				ball.fire(pos, target)
			else:
				ball.empty()
		2:
			if count > 0:
				mushroom.fire(pos, target)
			else:
				mushroom.empty()
		3:
			if count > 0:
				key.fire(pos, target)
			else:
				key.empty()


func is_in_jump() -> bool:
	return velocity.y > 0


func jump_signal(stage):
	match stage:
		1:
			velocity.y = -JUMP * 1.25
		2:
			velocity.y = -JUMP * 1.6


func apply_friction(friction: float) -> void:
	velocity.x = lerp(velocity.x, 0, friction)


func run(move_input: float, delta: float) -> void:
	look_right = move_input > 0
	velocity.x += move_input * ACCEL * delta
	velocity.x = clamp(velocity.x, -SPEED, SPEED)
	if not is_on_floor():
		apply_friction(AIR_FRIC)
	
	if action_ready:
		anim_state.travel("Run_Action")
	else:
		anim_state.travel("Run")


func stands() -> void:
	apply_friction(FRIC)
	
	if action_ready:
		anim_state.travel("Idle_Action")
	else:
		anim_state.travel("Idle")
