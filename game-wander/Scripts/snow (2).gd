extends Node2D



@export var camera: Camera2D
var can_zoom_camera

# zoom function
func _process(_delta: float) -> void:
	if can_zoom_camera == true:
		camera.zoom = lerp(camera.zoom, Vector2(0.6, 0.6), _delta)
	if can_zoom_camera == false:
		camera.zoom = lerp(camera.zoom, Vector2(1.0, 1.0), _delta)


# criteria meet
func _on_zoom_area_entered(body: Node2D) -> void:
	if body.has_meta("player"):
		can_zoom_camera = true


func _on_camera_zoom_body_exited(body: Node2D) -> void:
	if body.has_meta("player"):
		can_zoom_camera = false
