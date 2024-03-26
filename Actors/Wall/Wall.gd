extends Node2D

@export var shadow_offset = 0.5

var sun_vector = Vector2(1, -1)



var shadow_sprite : Sprite2D
var image_sprite : Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	shadow_sprite = get_node("Sprite2D2")
	image_sprite = get_node("Sprite2D")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	shadow_sprite.position = position.y * sun_vector * shadow_offset * -1
