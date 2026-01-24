extends Control

@onready var game_background = $GameBackground
@onready var black_overlay = $BlackOverlay
@onready var quote = $Quote
@onready var title = $Title
@onready var play_button = $PlayButton

@export var typing_speed = 25.0
@export var fade_out_speed = 10.0

func _ready():
	#Hides title and button during init
	title.modulate.a = 0
	play_button.modulate.a = 0
	
	play_button.disabled = true
	play_button.mouse_filter = Control.MOUSE_FILTER_STOP
	
	start_intro()
	
	#Starting the intro:	
func start_intro():
	#Calling universal dialogue manager. Pass 'quote' so the manager knows which label to animate here.
	await DialogueManager.type_text(quote,""" "'Whenever you feel like criticizing any one...
	just remember
	that all the people in this world
	haven’t had the advantages that you’ve had'"
	 """, typing_speed)
		
	#fading out overlay
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(black_overlay, "modulate:a", 0.0, fade_out_speed)
	tween.set_parallel(false)
	await tween.finished
	
	await get_tree().create_timer(3.0).timeout
	
	#Revealing title
	var tween_reveal_title = create_tween()
	tween_reveal_title.set_parallel(true)
	tween_reveal_title.tween_property(title, "modulate:a", 1.0, 5.0)
	await tween_reveal_title.finished
	
	await get_tree().create_timer(3.0).timeout
	
	var tween_reveal_button = create_tween()
	tween_reveal_button.tween_property(play_button, "modulate:a", 1.0, 5.0)
	await tween_reveal_button.finished
	
	play_button.disabled = false

#----------Button Logic----------
func _on_play_button_pressed():
	#This makes sure that it cannot be clicked twice by accident
	play_button.disabled = true
	
	SceneTransition.change_scene("res://main_game.tscn")

func _on_play_button_button_down():
	play_button.scale = Vector2(0.9, 0.9)

func _on_play_button_button_up():	
	play_button.scale = Vector2(1.0, 1.0)

func _on_play_button_mouse_entered():	
	play_button.scale = Vector2(1.1, 1.1)

func _on_play_button_mouse_exited():	
	play_button.scale = Vector2(1.0, 1.0)
