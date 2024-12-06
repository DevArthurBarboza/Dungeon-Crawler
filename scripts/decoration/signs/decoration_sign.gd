extends DecorationComponent

class_name DecorationSign

# Called when the node enters the scene tree for the first time.
func _ready():
	var _sign_texture: String = _textures_list.pick_random()
	if _sign_texture == "res://assets/Tiny Swords (Update 010)/Decoration/Signs/18.png" :
		$Texture.position = Vector2(-64,-128)
	$Texture.texture = load(_sign_texture)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
