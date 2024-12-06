extends BaseCharacter

class_name PlayerCharacter

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	#BaseCharacter.
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass

func _get_move_direction() -> Vector2:
	return Input.get_vector("move_left","move_right","move_up","move_down")

func get_attack_comands() -> String:
	if Input.is_action_just_pressed('left_attack'):
		return _left_attack_name
			
	if Input.is_action_just_pressed('right_attack'):
		return _right_attack_name
	return ''
