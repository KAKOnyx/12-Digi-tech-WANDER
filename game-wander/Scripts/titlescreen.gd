extends Node2D


# quit button
func _on_quit_pressed() -> void:
	get_tree().quit()

# play button
func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Snow.tscn")
