extends StaticBody2D
class_name GoldMine

const _GOLD_COLLECTABLE : PackedScene = preload('res://scenes/collectable/gold.tscn')

var _character_ref : BaseCharacter = null
var _current_prodution_timer: float = 0.0
@onready var _audio : AudioStreamPlayer2D = $Audio

var _mine_level : int = 0
var _mine_data : Dictionary = {
	0 : {
		"texture" : "res://assets/Tiny Swords (Update 010)/Resources/Gold Mine/GoldMine_Destroyed.png",
		"item_required" : {
			"item_name" : "madeira",
			"item_amount" : 10
		}
	},
	
	1 : {
		"texture" : "res://assets/Tiny Swords (Update 010)/Resources/Gold Mine/GoldMine_Inactive.png",
		"item_required" : {
			"item_name" : "madeira",
			"item_amount" : 25
		}
	},
	
	2: {
		"texture" : "res://assets/Tiny Swords (Update 010)/Resources/Gold Mine/GoldMine_Active.png",
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

func _on_gold_mine_area_body_entered(_body):
	if _body is BaseCharacter:
		_character_ref = _body
	pass # Replace with function body.


func _on_gold_mine_area_body_exited(_body):
	if _body is BaseCharacter:
		_character_ref = null
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_just_pressed('interact') and _character_ref != null:
		var _item_data : Dictionary = _mine_data[_mine_level]['item_required']
		if _character_ref.has_resource(
			_item_data["item_name"], _item_data["item_amount"]
		):
			_mine_level += 1
			
			if _mine_level == 2:
				if _audio.finished:
					_audio.play()
				_production_timer.start(_default_production_time)
			
			if _mine_level >= 3:
				_current_prodution_timer = _production_timer.time_left + _additional_production_time
				_production_timer.start(_current_prodution_timer)
				_mine_level = 2
				
			_sprite.texture = load(_mine_data[_mine_level]['texture'])
		return
	pass


func _on_production_timer_timeout():
	_mine_level = 1
	_audio.stop()
	_current_prodution_timer = 0
	_sprite.texture = load(_mine_data[_mine_level]["texture"])
	pass # Replace with function body.

func _spawn_gold():

	var _gold : CollectableComponent = _GOLD_COLLECTABLE.instantiate()
	_gold.global_position = global_position + Vector2(
		randi_range(-80,80),
		randi_range(64,96)
	)
	get_parent().call_deferred("add_child", _gold)
	
	pass

func _on_spawn_timer_timeout():
	
	if _mine_level < 2:
		return
	
	if _production_timer.time_left > 0:
		pass
	
	_spawn_gold()
	
	pass # Replace with function body.
