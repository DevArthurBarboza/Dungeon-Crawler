extends Node2D

@export var monster_scene: PackedScene
@export var spawn_interval: float = 2.0
@export var spawn_area: Rect2 = Rect2(Vector2(-200, -200), Vector2(400, 400))

var spawn_timer: Timer

func _ready():
	# Adiciona um Timer para controlar o spawn
	spawn_timer = Timer.new()
	spawn_timer.wait_time = spawn_interval
	spawn_timer.one_shot = false
	spawn_timer.autostart = true
	add_child(spawn_timer)
	spawn_timer.start()
	
	# Conecta o sinal para disparar o spawn
	spawn_timer.timeout.connect(spawn_monster)

func spawn_monster():
	if monster_scene:
		# Gera uma posição aleatória dentro da área de spawn
		var spawn_position = spawn_area.position + Vector2(
			randf() * spawn_area.size.x,
			randf() * spawn_area.size.y
		)
		# Instancia o monstro
		var monster = monster_scene.instantiate()
		monster.position = spawn_position
		get_parent().add_child(monster)
		#get_tree().root.add
		#get_tree().root.add_child(monster)
		#get_tree().add_child(monster)
		print("Monstro spawnado em: ", spawn_position)
