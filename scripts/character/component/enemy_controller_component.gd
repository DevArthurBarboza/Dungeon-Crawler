extends Node2D

class_name EnemyControllerComponent

var _direction : Vector2 

var _is_player_in_area : bool = false

var _target_position : Vector2

var _is_running = false

@export_category('Variables')
@export var _detection_radius : float = 200
@export var _time_for_running : int = 2

@export_category("Objects")
@export var _detection_area : Area2D
@export var _collision : CollisionShape2D
@export var _run_timer : Timer
@export var _rest_timer : Timer

func _ready():
	_collision.shape.radius = _detection_radius
	_direction = Vector2.ZERO

func _get_move_direction() -> Vector2 :
	return _direction

func _physics_process(delta):
	if !_is_player_in_area:
		_is_running = false
		_direction = Vector2.ZERO
		_run_timer.stop()
		return
	
	_run_timer.start(_time_for_running)
	
	_is_running = true
	_target_position = get_tree().get_first_node_in_group('player').global_position
	if _target_position.x > global_position.x :
		_target_position.x += 64
	
	if _target_position.x < global_position.x :
		_target_position.x -= 64 
	
	_direction = global_position.direction_to(_target_position)

func _on_detection_area_body_entered(body):
	if body is BaseCharacter:
		if body.is_controlled_by_player:
			_is_player_in_area = true
			_target_position = body.global_position
	pass # Replace with function body.as
	

func _on_detection_area_body_exited(body):
	if body is BaseCharacter:
		if body.is_controlled_by_player:
			_is_player_in_area = false
			_target_position = Vector2.ZERO
	pass # Replace with function body.


func _on_run_timer_timeout():
	_rest_timer.start(3)
	_direction = Vector2.ZERO
	set_physics_process(false)
	pass # Replace with function body.


func _on_rest_timer_timeout():
	set_physics_process(true)
	pass # Replace with function body.
