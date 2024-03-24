class_name ArrowAgent
extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func set_target_rotation(target_rotation : Vector2):
	var target_vector = Vector2(target_rotation.x + 8, target_rotation.y + 8)
	rotation_degrees = rad_to_deg(position.angle_to_point(target_vector)) + 90
func set_target_position(target_position):
	position = Vector2(target_position.x + 8, target_position.y + 8)
