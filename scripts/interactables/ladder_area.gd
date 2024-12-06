extends Area2D
class_name BridgeZIndexArea

var _state

@export_category("Variables")
@export var _is_revert : bool = false

func _on_body_exited(_body):
	if _body is BaseCharacter:
		
		if global_position.x > _body.global_position.x:
			_state = true
			if _is_revert:
				_state = false
			_body.update_mountain_state(_state)
			pass
			
		if global_position.x < _body.global_position.x:
			_state = false
			if _is_revert:
				_state = true
			_body.update_mountain_state(_state)
			pass
	pass # Replace with function body.


func _on_body_entered(_body):
	if _body is BaseCharacter:
		_body.update_mountain_state(true)
		return
		if global_position.x > _body.global_position.x:
			_state = true
			if _is_revert:
				_state = false
			_body.update_mountain_state(_state)
			pass
			
		if global_position.x < _body.global_position.x:
			_state = false
			if _is_revert:
				_state = true
			_body.update_mountain_state(_state)
			pass
	pass # Rep
