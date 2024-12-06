extends Area2D

class_name CollectableComponent


func _on_body_entered(body):
	if body is BaseCharacter:
		#body.add_item({'item_name' : 'wood', 
		#'item_amount' : [1,5], 
		#'item_texture' : 'res://assets/Tiny Swords (Update 010)/Resources/Resources/W_Idle.png' })
		queue_free()
	pass # Replace with function body.
