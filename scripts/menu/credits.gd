extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready():
	$EndCredits.start(15)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_end_credits_timeout():
	get_tree().change_scene_to_file("res://scenes/menu/menu.tscn")
	pass # Replace with function body.
