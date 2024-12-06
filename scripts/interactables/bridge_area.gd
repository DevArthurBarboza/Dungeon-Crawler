extends Area2D


class_name BridgeArea


func _on_body_entered(_body: Node2D):
	
	if _body is BaseCharacter:
		if _body.get_is_in_mountain():
			_body.update_collision_layer_mask('in')
	pass # Replace with function body.


func _on_body_exited(_body : Node2D):
	if _body is BaseCharacter:
		if _body.get_is_in_mountain():
			_body.update_collision_layer_mask('out')
	pass # Replace with function body.
