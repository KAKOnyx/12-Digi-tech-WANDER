extends CanvasLayer

signal on_transition_finished # emmited signal

@onready var color_rect = $ColorRect # Colour change
@onready var animation_player = $AnimationPlayer # animation that changes colour


func _ready():  # Colour transparent by default
	color_rect.visible = false 
	animation_player.animation_finished.connect(_on_animation_finished) # 


func _on_animation_finished(anim_name):
	if anim_name == "Fade_to_black": # If animation playing is called "Fade_to_black"
		on_transition_finished.emit() # and finished, the on_transtition_finsihed signal emits
		animation_player.play("fade_to_normal") # and plays the fade_to_normal animation
	elif anim_name == "fade_to_normal": # if animation playing is fade_to_normal
		color_rect.visible = false # hide color rect

func _transition():
	color_rect.visible = true # if color rect is visible
	animation_player.play("Fade_to_black") # play fade_to_black animation
