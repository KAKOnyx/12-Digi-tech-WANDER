class_name Player

extends CharacterBody2D


const SPEED: float = 350.0

var flipped_x: bool = false
@onready var anim = $AnimatedSprite2D as AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# Movement
	var v_direction: float = Input.get_axis("ui_up", "ui_down")
	var h_direction: float = Input.get_axis("ui_left", "ui_right")
	
	var direction: Vector2 = Vector2(h_direction, v_direction).normalized()
	velocity = direction * SPEED
	velocity - Vector2(SPEED * h_direction, SPEED * v_direction)

	move_and_slide()
	
	
	# Movement animation
	if Input.is_action_pressed("ui_right"):
		anim.play("right")
	elif Input.is_action_pressed("ui_left"):
		anim.play("left")
	elif Input.is_action_pressed("ui_up"):
		anim.play("up")
	elif Input.is_action_pressed("ui_down"):
		anim.play("down")
	else:
		anim.stop()


func _on_runestone_entered(area: Area2D) -> void:
	if area.has_meta("snow"):

			get_tree().call_deferred("change_scene_to_file", area.next_level)
