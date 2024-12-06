extends Node2D

class_name TimeCicle

const MINUTES_PER_DAY = 1440
const MINUTES_PER_HOUR = 60 
const INGAME_TO_REAL_MINUTE_DURATION = (2 * PI) / MINUTES_PER_DAY


signal time_tick(day:int,hour:int,minute:int)

@export var gradient:GradientTexture1D
@onready var canvas:CanvasModulate = $canvas

var time:float = 0.0
var past_minute = -1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	canvas.visible = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	var value = (sin(time - PI /2) + 1.0) / 2.0
	canvas.color = gradient.gradient.sample(value)

func recalculate_time():
	var total_minutes = int(time / INGAME_TO_REAL_MINUTE_DURATION )  
	
	var day = int(total_minutes / MINUTES_PER_DAY)
	
	var current_day_minutes = total_minutes % MINUTES_PER_DAY
	
	var hour = int(current_day_minutes / MINUTES_PER_HOUR)
	
	var minute = int(current_day_minutes % MINUTES_PER_HOUR)
	if past_minute != minute:
		past_minute = minute
		time_tick.emit(day,hour,minute)
