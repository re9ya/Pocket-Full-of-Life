extends Node

signal typing_finished

#This universal function takes the label object and types the input text
func type_text(label_node: Label, text_to_type: String, speed_seconds: float):
	
	#Set the text on the label
	label_node.text = text_to_type
	
	#Resets the visability to 0, invisible
	label_node.visible_ratio = 0.0
	
	#Creating the tween
	var tween = create_tween()
	tween.tween_property(label_node, "visible_ratio", 1.0, speed_seconds)
	
	#Waiting for the tween to finish
	await tween.finished
	
	#Notifies the rest of the game that it finished
	emit_signal("typing_finished")
