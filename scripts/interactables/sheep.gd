extends CharacterBody2D

class_name Sheep

const _HIT_PARTICLES : PackedScene = preload("res://scenes/effects/hit_particles.tscn")
const _MEAT_COLLECTABLE : PackedScene = preload('res://scenes/collectable/meat.tscn')

var _is_dead : bool = false

var _wait_time: float
var _run_wait_time : float
var _direction : Vector2 

var _regular_move_speed : float

@export_category('Variables')
@export var _move_speed: float = 128.0
@export var _min_health : int = 5
@export var _max_health : int = 15
@export var _min_meat : int = 1
@export var _max_meat : int = 3


@export_category("Objects")
@export var _sprite : Sprite2D
@export var _animation : AnimationPlayer
@export var _walk_timer : Timer
@export var _run_timer : Timer
@export var _dust : CPUParticles2D
@export var _health_component : HealthComponent

func _ready():
	_regular_move_speed = _move_speed
	_wait_time = randf_range(5.0, 15.0)
	_run_wait_time = randf_range(1.0,3.0)
	_direction = _get_direction()
	_walk_timer.start(_wait_time)
	_health_component._health_value = randi_range(_min_health,_max_health)

func _physics_process(delta):
	
	_dust.emitting = false
	if _direction:
		_dust.emitting = true
	
	velocity = _direction * _move_speed
	move_and_slide()
	
	if get_slide_collision_count() > 0:
		_direction = velocity.bounce(
			get_slide_collision(0).get_normal()
		).normalized()
		pass
	
	_animate()

func update_health(_damage_range : Array) -> void :
	
	_health_component.update_health([_damage_range[0],_damage_range[1]])
	_spawn_particles()
			
	if _health_component._is_dead:
		_spawn_meat()
		#_health_component.die()
		queue_free()
		return
		
	_direction = _get_direction()
	_move_speed *= 2
	_run_timer.start(_run_wait_time)
	pass


func _spawn_meat():
	var _meat_amount : int = randi_range(_min_meat,_max_meat)
	for _i in _meat_amount:
		var _meat : CollectableComponent = _MEAT_COLLECTABLE.instantiate()
		_meat.global_position = global_position + Vector2(
			randi_range(-32,32),
			randi_range(-32,32)
		)
		
		get_parent().call_deferred("add_child", _meat)
	
	pass
	
func _spawn_particles():
	var _particles = _HIT_PARTICLES.instantiate()
	_particles.global_position = global_position
	_particles.modulate = Color.RED
	_particles.emitting = true
	get_tree().root.call_deferred("add_child", _particles)
	
	pass

func _get_direction() -> Vector2:
	return [
			Vector2(-1,0), Vector2(1,0), Vector2(0,1), Vector2(0,-1),
			Vector2(-1,-1),Vector2(1,1),Vector2(1,-1),Vector2(-1,1),
			Vector2.ZERO 
		].pick_random().normalized()
	
func _animate():
	if velocity.x > 0:
		_sprite.flip_h = false
	
	if velocity.x < 0:
		_sprite.flip_h = true
		
	if velocity:
		_animation.play('walk')
		return
	_animation.play('idle')


func _on_walk_timer_timeout():
	_walk_timer.start(_wait_time)
	if _direction == Vector2.ZERO:
		_direction = _get_direction()
		return
	
	_direction = Vector2.ZERO
	pass # Replace with function body.


func _on_run_timer_timeout():
	_move_speed = _regular_move_speed
	pass # Replace with function body.
