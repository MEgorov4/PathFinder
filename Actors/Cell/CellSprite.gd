extends Sprite2D

var texture_variations_amount: int = 16
var texture_width : int = 16 


func _randomize_texture():
	var x = randi() % texture_variations_amount
	var y = randi() % texture_variations_amount
	region_rect.position.x = x * texture_width
	region_rect.position.y = y * texture_width 
	flip_h = randi() % 1
	flip_v = randi() % 1

# Called when the node enters the scene tree for the first time.
func _ready():
	_randomize_texture()



