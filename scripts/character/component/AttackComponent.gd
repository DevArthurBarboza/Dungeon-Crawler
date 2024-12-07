extends Node2D

class_name AttackComponent

@export_category("Objects")

@export_category('Variables')


@export var auto_attack : bool = false

@export var min_damage : float = 0
@export var max_damage : float = 3
@export var _right_attack_name : String = ''
@export var _left_attack_name : String = ''
@export var _attack_area_radius : int = 32

@onready var _can_attack : bool = true
@onready var is_controlled_by_player : bool = get_parent().is_controlled_by_player 
@onready var _attack_animation_name : String = ''

@onready var attack_area_collision : CollisionShape2D = $AttackArea/Collision
@onready var attack_area : Area2D = $AttackArea
@onready var auto_attack_area_collision : CollisionShape2D = $AutoAttackArea/Collision
@onready var auto_attack_area : Area2D = $AutoAttackArea

# Called when the node enters the scene tree for the first time.
func _ready():
	attack_area.position.x = 64
	attack_area_collision.shape.radius = _attack_area_radius
	auto_attack_area.position.x = 64
	auto_attack_area_collision.shape.radius = _attack_area_radius
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	attack()
	pass

func update_collision_disabled_state(state : bool):
	attack_area_collision.disabled = state


func attack():
	process_attack_name()
	if _attack_animation_name and _can_attack:
		_can_attack = false
		#set_physics_process(false)
		return
		

func process_attack_name():
	if is_controlled_by_player:
		if Input.is_action_just_pressed('right_attack'):
			_attack_animation_name = _right_attack_name
		if Input.is_action_just_pressed('left_attack'):
			_attack_animation_name = _left_attack_name
		return

	return false


func _on_attack_area_body_entered(body):
	if body == self:
		print('doideira')
	if (
		
		body.has_node('HealthComponent')
	):
		body.update_health([min_damage,max_damage]) # Replace with function body.


func _on_auto_attack_area_body_entered(body):
	if body == self:
		return
	if (
		body is BaseCharacter and
		body.get('is_controlled_by_player') and body.is_controlled_by_player and
		body.has_node('HealthComponent') 
	):
		if auto_attack and _attack_animation_name == '':
			var random_index = randi() % 2
			_attack_animation_name = _right_attack_name if random_index else _left_attack_name
			_can_attack = false
	pass # Replace with function body.
