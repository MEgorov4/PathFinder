class_name ArrowAgent
extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func set_target_rotation(target_rotation : Vector2):
	var target_vector = Vector2(target_rotation.x, target_rotation.y)
	rotation_degrees = rad_to_deg(position.angle_to_point(target_vector)) + 90
func set_target_position(target_position : Vector2):
	position = Vector2(target_position.x + 8, target_position.y + 8)
