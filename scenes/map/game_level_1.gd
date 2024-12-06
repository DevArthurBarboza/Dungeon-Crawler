extends Node2D


@export var _is_menu : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if _is_menu:
		for child in find_children('*','BaseCharacter'):
			child.find_child('CharacterCamera').enabled = false
			child.is_controlled_by_player = false
	#
	
	#find_child('HUD').visible = false
	#find_child('CanvasModulate').visible = false
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
