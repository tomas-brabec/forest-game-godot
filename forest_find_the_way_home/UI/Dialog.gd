extends Control



func _on_Rest_pressed() -> void:
	get_tree().reload_current_scene()


func _on_Menu_pressed() -> void:
	get_tree().change_scene("res://UI/Menu.tscn")


func _on_Cont_pressed() -> void:
	hide()


func hide():
	visible = false
	$Menu.disabled = true
	$Cont.disabled = true
	$Rest.disabled = true


func show():
	visible = true
	$Menu.disabled = false
	$Cont.disabled = false
	$Rest.disabled = false


func home():
	$text.visible = true
	$coin.visible = true
	var coins = get_node("../Inventory").get_count(4)
	$coin/Label.text = "coins: " + str(coins)
