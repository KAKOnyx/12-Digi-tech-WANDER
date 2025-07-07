extends Node2D

var map_position = Vector2.ZERO

@export var current_level: Node2D


func _on_left_body_entered(body: Node2D) -> void:
	if body is Player:
		_load_level(current_level.left, Vector2(-3456, 0))
	

func _on_top_body_entered(body: Node2D) -> void:
	if body is Player:
		_load_level(current_level.top, Vector2(0, -1968))


func _on_right_body_entered(body: Node2D) -> void:
	if body is Player:
		_load_level(current_level.right, Vector2(3456, 0))


func _on_bottom_body_entered(body: Node2D) -> void:
	if body is Player:
		_load_level(current_level.bottom, Vector2(0, 1968))

func _load_level(level: PackedScene, pos):
	var L = level.instantiate()
	L.position = pos + map_position
	map_position = L.position
	
	add_child(L)
	current_level = L
	
	get_node("area2d").position = map_position
