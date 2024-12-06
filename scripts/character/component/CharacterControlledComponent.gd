extends Node2D

class_name CharacterControllerComponent

@export var is_controlled_by_player : bool = false

func _get_move_direction() -> Vector2:
	if is_controlled_by_player:
		return Input.get_vector("move_left","move_right","move_up","move_down")
	return Vector2.ZERO
