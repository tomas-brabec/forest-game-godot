extends Control





func _on_Help_pressed() -> void:
	$Sprite.frame = 0
	$Sprite.visible = true
	$Next.visible = true
	$Prev.visible = true
	
	$Play.disabled = true
	$Help.disabled = true
#	$Exit.disabled = true
	$CheckBox.disabled = true


func _on_Next_pressed() -> void:
	var frame = $Sprite.frame
	if frame == 8:
		$Sprite.visible = false
		$Next.visible = false
		$Prev.visible = false
		
		$Play.disabled = false
		$Help.disabled = false
#		$Exit.disabled = false
		$CheckBox.disabled = false
	else:
		$Sprite.frame = frame + 1


func _on_Prev_pressed() -> void:
	var frame = $Sprite.frame
	if frame == 0:
		$Sprite.visible = false
		$Next.visible = false
		$Prev.visible = false
		
		$Play.disabled = false
		$Help.disabled = false
#		$Exit.disabled = false
		$CheckBox.disabled = false
	else:
		$Sprite.frame = frame - 1


func _on_Exit_pressed() -> void:
	get_tree().quit()


func _on_CheckBox_toggled(button_pressed: bool) -> void:
	OS.window_fullscreen = button_pressed


func _on_Play_pressed() -> void:
	get_tree().change_scene("res://Level.tscn")
