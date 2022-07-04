extends TileMap


var Wall_break = preload("res://Environment/KeyWallSprite.tscn")


#func _input(event: InputEvent) -> void:
#	if event.is_action_pressed("fire"):
#		open_wall(get_global_mouse_position())


func open_wall(position: Vector2) -> void:
	var coordinates = world_to_map(self.to_local(position))
	
	create_effect(coordinates)
	
	destroy_wall(coordinates, Vector2.UP)
	destroy_wall(coordinates, Vector2.DOWN)


func destroy_wall(coordinates: Vector2, vector: Vector2) -> void:
	var block_exist = true
	var coord: Vector2 = coordinates
	
	while block_exist:
		coord += vector
		if get_cellv(coord) != -1:
			create_effect(coord)
		else:
			block_exist = false


func create_effect(coordinates: Vector2) -> void:
	var wall_break = Wall_break.instance()
	var glob = map_to_world(coordinates)
	glob = to_global(glob)
	wall_break.global_position = glob + Vector2(20, 20)
	set_cellv(coordinates, -1)
	get_tree().current_scene.add_child(wall_break)
