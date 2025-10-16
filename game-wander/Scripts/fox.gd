class_name Fox

extends CharacterBody2D


const SPEED: float = 130.0


var fragment_score : int = 0
@export var ui : Node
@export var fragment_collect : Node
@export var footstep : Node
var footstep_can_play

var flipped_x: bool = false
@onready var anim = $AnimatedSprite2D as AnimatedSprite2D 
#@onready var fox_col = $fox_collision as CollisionShape2D #colliding with objects
#@onready var play_col = $player_collision/player_collison_shape as CollisionShape2D #interacting with objects


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	# Movement - inputs
	var v_direction: float = Input.get_axis("ui_up", "ui_down")
	var h_direction: float = Input.get_axis("ui_left", "ui_right")
	"res://Scripts/mapdirection.gd"
	
	var direction: Vector2 = Vector2(h_direction, v_direction).normalized()
	velocity = direction * SPEED
	@warning_ignore("standalone_expression")
	velocity - Vector2(SPEED * h_direction, SPEED * v_direction)

	move_and_slide()
	
	# exit main game to title screen
	if Input.is_action_pressed("ui_esc"):
		print("escape") # checks input goes through
		get_tree().call_deferred("change_scene_to_file", "res://scenes/titlescreen.tscn") # file changes to title screen
	
	# animation and audio playing based on user inputs/movement
	if Input.is_action_pressed("ui_right"):
		anim.play("right") # play walking animation
		footstep_can_play = true # footstep audio can play
	elif Input.is_action_pressed("ui_left"):
		anim.play("left") # play walking animation
		footstep_can_play = true # footstep audio can play
	elif Input.is_action_pressed("ui_up"):
		footstep_can_play = true # footstep audio can play
	elif Input.is_action_pressed("ui_down"):
		footstep_can_play = true # footstep audio can play
	else:
		footstep_can_play = false # footstep audio can't play
		anim.stop() # all animations stop
		

# collecting and counting fragments + sound effect
func _on_fragment_touched(area: Area2D) -> void:
	if area.has_meta("fragment"):
		fragment_score += 1 # adding score
		ui.text = str(fragment_score)
		print(fragment_score) # visual score
		Global.fragments.append(area)
		area.queue_free() # removing instance
		var iteration: int = 0
		for fragment in Global.fragments:
			if iteration >= 12:
				break
			print("ding")
			fragment_collect.pitch_scale = Global.pitches[iteration]
			fragment_collect.play() # sound effect
			#await fragment_collect.finished
			await get_tree().create_timer(0.8).timeout # wait for timer to finish
			iteration += 1 # increses the fragment amount counter by one


#footstep sound effect
func _on_footstep_timer_timeout() -> void:
	if footstep_can_play == true: # checks if footstep audio can play
		footstep.play() # plays audio
	else:
		print("false")
		footstep.stop() # if footstep audio can't play, stops audio


# next level function
func _on_runestone_entered(area: Area2D) -> void:
	if area.has_meta("nextlevel"): # checks for meta of area close around runestone
		TransitionScreen._transition()
		await TransitionScreen.on_transition_finished # waits for the on_transition_signal to emit
			
		get_tree().call_deferred("change_scene_to_file", area.next_level) # changes scene to title screen
