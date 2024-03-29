extends Node2D
#Components
var animation_player : AnimationPlayer
var sound_player : AudioStreamPlayer2D

#Parameters
@export var shadow_offset = 0.9

#variables
var sun_vector = Vector2(-1, 1)
var shadow_sprite : Sprite2D
var image_sprite : Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player = get_node("AnimationPlayer")
	sound_player = get_node("AudioStreamPlayer2D")

	shadow_sprite = get_node("Sprite2D2")
	image_sprite = get_node("Sprite2D")
	
	sound_player.pitch_scale *= randf_range(0.75, 1)
	animation_player.play("Wall_Fall")
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		shadow_sprite.position = Vector2(position.y * sun_vector.y * shadow_offset * -1 + 8, position.y * sun_vector.y * shadow_offset + 4)
	
