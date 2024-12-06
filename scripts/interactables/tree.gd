extends StaticBody2D

class_name PhysicsTree

const _HIT_PARTICLES : PackedScene = preload("res://scenes/effects/hit_particles.tscn")
const _WOOD_COLLECTABLE : PackedScene = preload('res://scenes/collectable/wood.tscn')
var _is_dead : bool = false

@export_category('Variables')
@export var _health : int
@export var _min_health : int = 10
@export var _max_health : int = 15
@export var _min_wood : int = 1
@export var _max_wood : int = 5

@export_category('Objects')
@export var _animation: AnimationPlayer
@export var _health_component: HealthComponent
# Called when the node enters the scene tree for the first time.
func _ready():
	_health_component._health_value = randi_range(_min_health,_max_health)  
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_health(_damage_range : Array) -> void :
	
	if _health_component._is_dead:
		print('already killed')
		return
		
	_health_component.update_health([_damage_range[0],
		_damage_range[1]])
		
	_spawn_particles()
	
	if _health_component._is_dead :
		_spawn_wood()
		print('killed')
		_animation.play('kill')
		#set_process(false)
		return

	_animation.play('hit')
	pass


func _spawn_particles():
	var _particles = _HIT_PARTICLES.instantiate()
	_particles.global_position = global_position + Vector2(32,32)
	_particles.modulate = Color.SADDLE_BROWN
	_particles.emitting = true
	get_tree().root.call_deferred("add_child", _particles)

func _on_animation_animation_finished(anim_name):
	if anim_name == 'hit':
		_animation.play('idle')
	#if anim_name == 'kill':
		#set_process(false)
	pass # Replace with function body.

func _spawn_wood():
	var _wood_amount : int = randi_range(_min_wood,_max_wood)
	for _i in _wood_amount:
		var _wood : CollectableComponent = _WOOD_COLLECTABLE.instantiate()
		_wood.global_position = global_position + Vector2(
			randi_range(-32,32),
			randi_range(-32,32)
		)
		
		
		get_parent().call_deferred("add_child", _wood)
		
		
		




