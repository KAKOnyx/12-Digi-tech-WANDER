extends Node2D


@export var camera: Camera2D
var can_zoom_camera



# camera zooms out when within a certain area of runestone
func _process(_delta: float) -> void:
	if can_zoom_camera == true:
		camera.zoom = lerp(camera.zoom, Vector2(2.6, 2.6), _delta) # zoom out
	if can_zoom_camera == false:
		camera.zoom = lerp(camera.zoom, Vector2(3.0, 3.0), _delta) # zoom back in when exited area


# checks if player is within the area
func _on_zoom_area_entered(body: Node2D) -> void:
	if body.has_meta("player"):
		can_zoom_camera = true

# checks when player has exited the area
func _on_camera_zoom_body_exited(body: Node2D) -> void:
	if body.has_meta("player"):
		can_zoom_camera = false
