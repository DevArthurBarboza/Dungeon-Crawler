extends Node2D

class_name HealthComponent

var _is_dead : bool = false
var _can_hit : bool = true

var DEFAULT_DEATH_ANIMATION_SCENE_PATH = 'res://scenes/effects/tropper_death_effect.tscn'

@export_category('Objects')


@onready var _timer : Timer = $Timer
#@export var _damage_bar : ProgressBar
@export var _animation : AnimationPlayer
@onready var _damage_bar : ProgressBar = $HealthBar
@onready var _health_bar : ProgressBar = $HealthBar;

@export_category('Variables')
@export var _animation_hit_name = 'hit'
@export var _play_animation : bool = true
@export var _health_value : float = 10 
@export var _show_health_bar : bool = true

var _death_animation

# Called when the node enters the scene tree for the first time.
func _ready():
	#pass
	_health_bar.visible = _show_health_bar
	_damage_bar.max_value = _health_value
	#_damage_bar.value = _health_value

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
		#get_parent().call_deferred("add_child", _death_animation.instantiate())
	
func play_die_scene():
	if _play_animation:
		_death_animation =  load(DEFAULT_DEATH_ANIMATION_SCENE_PATH).instantiate()
		_death_animation.position = global_position
		get_tree().root.call_deferred("add_child",_death_animation)
	
func check_is_dead():
	if _health_value <= 0:
		_is_dead = true
		play_die_scene()
	
func update_health(damage):
	if !_can_hit:
		pass
	if typeof(damage) == TYPE_ARRAY:
		damage = randi_range(damage[0],damage[1])
	var prev_health = _health_value
	_health_value -= damage
	if _health_value < prev_health:
		_timer.start()
	else:
		_damage_bar.value = _health_value
	check_is_dead()
	_can_hit = false
	#parent._animation.play(_animation_hit_name)
	#parent._animation.play('attack_hammer')
	return


func _on_timer_timeout():
	_damage_bar.value = _health_value
	pass # Replace with function body.
