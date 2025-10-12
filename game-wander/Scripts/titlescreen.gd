extends Node2D


# quit button - if clicked, game closes
func _on_quit_pressed() -> void:
	get_tree().quit()

# play button - if clicked, scene is changed to main game
func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/raidho.tscn")

func _ready() -> void: 
	Global.fragments = [] # resets fragments collected when user exits to titlescreen
