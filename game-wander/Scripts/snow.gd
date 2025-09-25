extends Node2D


@export var camera: Camera2D
var can_zoom_camera



# camera zooms out when in certain area of runestone
func _process(_delta: float) -> void:
	if can_zoom_camera == true:
		camera.zoom = lerp(camera.zoom, Vector2(2.6, 2.6), _delta)
	if can_zoom_camera == false:
		camera.zoom = lerp(camera.zoom, Vector2(3.0, 3.0), _delta)


# criteria for zoom
func _on_zoom_area_entered(body: Node2D) -> void:
	if body.has_meta("player"):
		can_zoom_camera = true


func _on_camera_zoom_body_exited(body: Node2D) -> void:
	if body.has_meta("player"):
		can_zoom_camera = false
