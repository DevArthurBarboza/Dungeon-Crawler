extends Node2D


class_name DecorationComponent


@export_category('Variables')
@export var _textures_list: Array[String]


# Called when the node enters the scene tree for the first time.
func _ready():
	for _children in get_children():
		if _children is Sprite2D:
			_children.texture = load(_textures_list.pick_random())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
