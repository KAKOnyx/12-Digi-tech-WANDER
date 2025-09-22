class_name Fox

extends CharacterBody2D


const SPEED: float = 150.0


var fragment_score : int = 0
@export var ui : Node
@export var fragment_collect : Node
@export var footstep : Node
var footstep_can_play

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
	"res://Scripts/mapdirection.gd"
	
	var direction: Vector2 = Vector2(h_direction, v_direction).normalized()
	velocity = direction * SPEED
	velocity - Vector2(SPEED * h_direction, SPEED * v_direction)

	move_and_slide()
	
	
	# direction/rotation based on movement input for animated sprite and collision shapes
	if Input.is_action_pressed("ui_right"):
		anim.play("right") #play walking animation
		fox_col.rotation = deg_to_rad(0)#colliding collision rotation
		play_col.rotation = deg_to_rad(0)#interacting collision rotation
		footstep_can_play = true#footstep audio check
	elif Input.is_action_pressed("ui_left"):
		anim.play("left") #play walking animation
		fox_col.rotation = deg_to_rad(0)#colliding collision rotation
		play_col.rotation = deg_to_rad(0)#interacting collision rotation
		footstep_can_play = true#footstep audio check
	elif Input.is_action_pressed("ui_up"):
		fox_col.rotation = deg_to_rad(90)#colliding collision rotation
		play_col.rotation = deg_to_rad(90)#interacting collision rotation
		footstep_can_play = true#footstep audio check
	elif Input.is_action_pressed("ui_down"):
		fox_col.rotation = deg_to_rad(90)#colliding collision rotation
		play_col.rotation = deg_to_rad(90)#interacting collision rotation
		footstep_can_play = true#footstep audio check
	else:
		anim.stop()
		footstep_can_play = false


# collecting and counting fragments + sound effect
func _on_fragment_touched(area: Area2D) -> void:
	if area.has_meta("fragment"):
		fragment_score += 1 #adding score
		ui.text = str(fragment_score)
		print(fragment_score) #visual score
		Global.fragments.append(area)
		area.queue_free()#removing instance
		var iteration: int = 0
		for fragment in Global.fragments:
			fragment_collect.pitch_scale = Global.pitches[iteration]
			fragment_collect.play() #sound effect
			#await fragment_collect.finished
			await get_tree().create_timer(0.8).timeout
			iteration += 1
		

#footstep sound effect
func _on_footstep_timer_timeout() -> void:
	if footstep_can_play == true:
		footstep.play()
	else:
		footstep.stop()


# next level function
func _on_runestone_entered(area: Area2D) -> void:
	if area.has_meta("nextlevel"):

			get_tree().call_deferred("change_scene_to_file", area.next_level)
