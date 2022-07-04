extends Control


var selected: int = 0

var count1:int = 0
var count2:int = 0
var count3:int = 0
var count4:int = 0
var count5:int = 0

onready var label_1 = $Can/Label
onready var label_2 = $Ball/Label
onready var label_3 = $Mushroom/Label
onready var label_4 = $Key/Label
onready var label_5 = $Coin/Label

onready var rect_1 = $Can
onready var rect_2 = $Ball
onready var rect_3 = $Mushroom
onready var rect_4 = $Key
#3ce3f4d7 64e3f4d7
var default_color: Color = Color("3ce3f4d7")
var selected_color: Color = Color("e3f4d7")

signal selecion_change(index)

func _ready() -> void:
	change_selection(selected)


func _input(event: InputEvent) -> void:
	var old: int = selected
	if event.is_action_pressed("item1"):
		selected = 0
	elif event.is_action_pressed("item2"):
		selected = 1
	elif event.is_action_pressed("item3"):
		selected = 2
	elif event.is_action_pressed("item4"):
		selected = 3
	
	if event.is_action_pressed("wheel_down"):
		if selected < 3:
			selected +=1
		else:
			selected = 0
	elif event.is_action_pressed("wheel_up"):
		if selected > 0:
			selected -=1
		else:
			selected = 3
	
	if selected != old:
		change_selection(selected, old)


func add_item(index: int, value: int = 1):
	match index:
		0:
			count1 += value
		1:
			count2 += value
		2:
			count3 += value
		3:
			count4 += value
		4:
			count5 += value
	
	refresh_label_text(index)


func refresh_label_text(index: int) -> void:
	match index:
		0:
			label_1.text = str(count1)
		1:
			label_2.text = str(count2)
		2:
			label_3.text = str(count3)
		3:
			label_4.text = str(count4)
		4:
			label_5.text = str(count5)


func change_selection(new_index: int, old_index: int = -1) -> void:
	match new_index:
		0:
			rect_1.set_frame_color(selected_color)
		1:
			rect_2.set_frame_color(selected_color)
		2:
			rect_3.set_frame_color(selected_color)
		3:
			rect_4.set_frame_color(selected_color)
	
	match old_index:
		0:
			rect_1.set_frame_color(default_color)
		1:
			rect_2.set_frame_color(default_color)
		2:
			rect_3.set_frame_color(default_color)
		3:
			rect_4.set_frame_color(default_color)
	
	emit_signal("selecion_change", new_index)


func get_count(index: int) -> int:
	match index:
		0:
			return count1
		1:
			return count2
		2:
			return count3
		3:
			return count4
		4:
			return count5
	
	return -1


func update_count(index: int) -> void:
	match index:
		0:
			count1 -= 1
		1:
			count2 -= 1
		2:
			count3 -= 1
		3:
			count4 -= 1
		4:
			count5 -= 1
	
	refresh_label_text(index)


func set_count(index: int, value: int) -> void:
	match index:
		0:
			count1 += value
		1:
			count2 += value
		2:
			count3 += value
		3:
			count4 += value
	
	refresh_label_text(index)
