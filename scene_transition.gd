extends CanvasLayer
#Defines "Signal" that we can listen for
signal fade_completed

@onready var color_rect = $ColorRect

func fade_to_black():
	#Create a tween (animation object). Tweens animate a value from A to B. Like a PID controller
	var tween = create_tween()
	
	#fading out slowly
	tween.tween_property(color_rect, "modulate:a", 1.0, 0.5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	
	#Notifies when tween is finished
	await tween.finished
	emit_signal("fade_completed")

func fade_to_clear():
	var tween = create_tween()
	tween.tween_property(color_rect, "modulate:a", 0.0, 0.5)
	await tween.finished
	emit_signal("fade_completed")

#Public static helper method that handles scene changes automatically
func change_scene(target_path: String):
	#fade to black
	await fade_to_black()
	
	#changing the scene
	get_tree().change_scene_to_file(target_path)
	
	#clearing up to scene
	await fade_to_clear()
