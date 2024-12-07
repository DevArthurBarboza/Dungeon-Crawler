extends CharacterBody2D

class_name BaseCharacter


#var _can_attack : bool = true
#var _attack_animation_name : String = ""
var _is_in_mountain : bool = false
var hitted : bool = false


@export_category('Variables')
@export var _move_speed : float = 256
@export var _left_attack_name : String = ""
@export var _right_attack_name : String = ""
@export var _area_attack_radius : int = 32
@export var _min_attack : int = 1
@export var _max_attack : int = 5
@export var _is_peaceful : bool = false
#@export var _health : int = 10
#@export var _is_main_character : bool = false

@export_category("Objects")
@export var _animation : AnimationPlayer
@export var _sprite2D : Sprite2D
@export var _dust : CPUParticles2D
@export var _camera : Camera2D
@export var _attack_component : AttackComponent
@export var _health_component : HealthComponent
@export var _character_controller_component : CharacterControllerComponent
@export var _enemy_controller : Node2D
@export var is_controlled_by_player : bool = false

@export var _is_menu : bool = false


func _ready():
	_character_controller_component.is_controlled_by_player = is_controlled_by_player
	_attack_component._right_attack_name = _right_attack_name
	_attack_component._left_attack_name = _left_attack_name
	_attack_component.attack_area_collision.shape.radius = _area_attack_radius
	_attack_component.auto_attack_area_collision.shape.radius = _area_attack_radius
	_attack_component.max_damage = _max_attack
	_attack_component.min_damage = _min_attack
	
	if _is_menu:
		queue_free()
		return
		
	if (!_character_controller_component.is_controlled_by_player):
		_camera.enabled = false
		return
	pass

func _physics_process(_delta):
	#print(_delta)
	_move()
	_animate()
	
	if(_health_component._is_dead):
		if is_controlled_by_player:
			get_tree().change_scene_to_file("res://scenes/menu/you_died.tscn")
		queue_free()
	pass
	
func _move() -> void:
	var _direction : Vector2
	_direction = _get_move_direction()

	_dust.emitting = false
	if _direction:
		_dust.emitting = true
	velocity = _direction * _move_speed
	move_and_slide()

func _get_move_direction() -> Vector2:
	if is_controlled_by_player:
		return _character_controller_component._get_move_direction()
	if _enemy_controller:
		return _enemy_controller._get_move_direction()
	return Vector2(0,0)

func _animate() -> void :
	if velocity.x > 0:
		_sprite2D.flip_h = false
		_attack_component.attack_area.position.x = 64
		_attack_component.auto_attack_area.position.x = 64
	
	if velocity.x < 0 :
		_sprite2D.flip_h = true
		_attack_component.attack_area.position.x = -64
		_attack_component.auto_attack_area.position.x = -64
		

	if !_attack_component._can_attack and !hitted: 
		set_physics_process(false)
		_animation.play(_attack_component._attack_animation_name)
		return
	
	if !_health_component._can_hit:
		#set_physics_process(false)
		hitted = true
		_animation.play(_health_component._animation_hit_name)
		return

	if velocity:
		_animation.play('run')
		return
		
	_animation.play('idle')
	
func _on_animation_finished(anim_name):
	if anim_name == _attack_component._attack_animation_name:
		_attack_component._can_attack = true
		_attack_component._attack_animation_name = ''
		set_physics_process(true)
	if anim_name == _health_component._animation_hit_name:
		_health_component._can_hit = true
		hitted = false
	pass # Replace with function body.

func update_collision_layer_mask(_type: String) -> void:
	
	if _type == 'in':
		set_collision_layer_value(1,false)
		set_collision_layer_value(2,true)
		
		set_collision_mask_value(1,false)
		set_collision_mask_value(2,true)
		pass
		
	if _type == 'out':
		set_collision_layer_value(1,true)
		set_collision_layer_value(2,false)
		set_collision_mask_value(1,true)
		set_collision_mask_value(2,false)
		pass

func update_mountain_state(_state : bool) -> void:
	_is_in_mountain = _state
	if _is_in_mountain:
		self.z_index = 1
		return
		
	self.z_index = 0
	
func has_resource(_item_name : String, _item_amount: int) -> bool:
	return true
	
func get_is_in_mountain() -> bool:
	return _is_in_mountain

func update_health(_damage_range : Array):
	_health_component.update_health(_damage_range)
	_health_component._can_hit = false
	pass
