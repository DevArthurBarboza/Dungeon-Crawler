extends StaticBody2D


class_name House


const SOLDIER : PackedScene = preload("res://scenes/character/pawn.tscn")

var _character_ref : BaseCharacter = null
var _current_prodution_timer: float = 0.0
#@onready var _audio : AudioStreamPlayer2D = $Audio

var _house_level : int = 0
var _house_data : Dictionary = {
	0 : {
		"texture" : "res://assets/Tiny Swords (Update 010)/Factions/Knights/Buildings/House/House_Construction.png",
		"item_required" : {
			"item_name" : "madeira",
			"item_amount" : 10
		}
	},
	
	1 : {
		"texture" : "res://assets/Tiny Swords (Update 010)/Factions/Knights/Buildings/House/House_Blue.png",
		"item_required" : {
			"item_name" : "madeira",
			"item_amount" : 25
		}
	},
	
	2: {
		"texture" : "res://assets/Tiny Swords (Update 010)/Factions/Knights/Buildings/House/House_Destroyed.png",
		"item_required" : {
			"item_name" : "madeira",
			"item_amount" : 5
		}
	}
}


@export_category("Variables")
@export var _default_production_time : float = 10.0
@export var _additional_production_time : float = 15.0

@export_category("Objects")
@export var _sprite : Sprite2D
@export var _production_timer : Timer
@export var _spawn_timer : Timer


func _ready():
	pass


func _on_house_area_body_entered(_body):
	if _body is BaseCharacter:
		_character_ref = _body
	pass # Replace with function body.


func _on_house_area_body_exited(_body):
	print(_body)
	if _body is BaseCharacter:
		_character_ref = null
	pass # Replace with function body.

func _process(delta):
	#print(_character_ref)
	if Input.is_action_just_pressed('interact') and _character_ref != null:
		#var _item_data : Dictionary = _mine_data[_mine_level]['item_required']
		#if _character_ref.has_resource(
			#_item_data["item_name"], _item_data["item_amount"]
		#):
		_house_level += 1
		
		if _house_level > 1:
			_spawn_soldier()
			_production_timer.start(_default_production_time)
			_house_level = 1
		
		if _house_level == 2:
			#if _audio.finished:
				#_audio.play()
			_production_timer.start(_default_production_time)
		
		if _house_level >= 3:
			_current_prodution_timer = _production_timer.time_left + _additional_production_time
			_production_timer.start(_current_prodution_timer)
			_house_level = 2
			
		_sprite.texture = load(_house_data[_house_level]['texture'])
	pass


func _on_production_timer_timeout():
	_house_level = 1
	#_audio.stop()
	_current_prodution_timer = 0
	_sprite.texture = load(_house_data[_house_level]["texture"])
	pass # Replace with function body.

func _spawn_soldier():

	var pawn = SOLDIER.instantiate()
	pawn.global_position = global_position + Vector2(
		randi_range(-100,100),
		randi_range(84,116)
	)
	get_parent().call_deferred("add_child", pawn)
	
	pass

func _on_spawn_timer_timeout():
	
	if _house_level < 2:
		return
	
	if _production_timer.time_left > 0:
		pass
	
	_spawn_soldier()
	
	pass # Replace with function body.
