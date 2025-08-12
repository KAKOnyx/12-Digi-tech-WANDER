class_name Fox

extends CharacterBody2D


const SPEED: float = 300.0


var fragment_score : int = 0
@export var ui : Node

var flipped_x: bool = false
@onready var anim = $AnimatedSprite2D as AnimatedSprite2D 
@onready var fox_col = $fox_collision as CollisionShape2D #colliding with objects
@onready var play_col = $player_collision/player_collison_shape as CollisionShape2D #interacting with objects




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	# Movement
	var v_direction: float = Input.get_axis("ui_up", "ui_down")
	var h_direction: float = Input.get_axis("ui_left", "ui_right")
	
	var direction: Vector2 = Vector2(h_direction, v_direction).normalized()
	velocity = direction * SPEED
	velocity - Vector2(SPEED * h_direction, SPEED * v_direction)

	move_and_slide()
	
	
	# direction/rotation based on movement input for animated sprite and collision shapes
	if Input.is_action_pressed("ui_right"):
		anim.play("right")
		fox_col.rotation = deg_to_rad(0)
		play_col.rotation = deg_to_rad(0)
	elif Input.is_action_pressed("ui_left"):
		anim.play("left")
		fox_col.rotation = deg_to_rad(0)
		play_col.rotation = deg_to_rad(0)
	elif Input.is_action_pressed("ui_up"):
		anim.play("up")
		fox_col.rotation = deg_to_rad(90)
		play_col.rotation = deg_to_rad(90)
	elif Input.is_action_pressed("ui_down"):
		anim.play("down")
		fox_col.rotation = deg_to_rad(90)
		play_col.rotation = deg_to_rad(90)
	else:
		anim.stop()


# collecting and counting fragments
func _on_fragment_touched(area: Area2D) -> void:
	if area.has_meta("fragment"):
		fragment_score += 1
		ui.text = str(fragment_score)
		print(fragment_score)
		area.queue_free()


# next level function
func _on_runestone_entered(area: Area2D) -> void:
	if area.has_meta("nextlevel"):

			get_tree().call_deferred("change_scene_to_file", area.next_level)
