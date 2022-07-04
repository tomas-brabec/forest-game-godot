extends Node2D



func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu"):
		if $CanvasLayer/Dialog.visible:
			$CanvasLayer/Dialog.hide()
		else:
			$CanvasLayer/Dialog.show()


func _on_Area2D_body_entered(body: Node) -> void:
	$CanvasLayer/Dialog.home()
	$CanvasLayer/Dialog.show()
