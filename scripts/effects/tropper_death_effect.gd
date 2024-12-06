extends Node2D

class_name TropperDeathEffect

@export var _animation : AnimationPlayer
@export var _sprite : Sprite2D
@export var _disapperTimer : Timer

# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	die()
	pass

func die():
	_animation.play('die')


func _on_animation_player_animation_finished(anim_name):
	if anim_name == 'die':
		_disapperTimer.start(5)
		return
	
	if anim_name == 'disapper':
		queue_free()
	
	pass # Replace with function body.


func _on_disapper_timer_timeout():
	_animation.play('disapper')
	pass # Replace with function body.
