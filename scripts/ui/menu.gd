extends Control

class_name Menu


@export_category('Variables')

@export var first_level : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():

	#for child in find_children('*','BaseCharacter'):
		#child.find_child('CharacterCamera').enabled = false
	#
	#find_child('HUD').visible = false
	#find_child('CanvasModulate').visible = false
	
	pass # Replace with function body.

func _on_start_pressed():
	get_tree().change_scene_to_file(first_level.resource_path)
	pass # Replace with function body.


func _on_credit_pressed():
	get_tree().change_scene_to_file("res://scenes/menu/credits.tscn")
	pass # Replace with function body.


func _on_quit_pressed():
	get_tree().quit()
	pass # Replace with function body.
