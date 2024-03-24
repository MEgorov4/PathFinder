class_name ArrowAgent
extends Node2D


var target_look_point : Vector2 = Vector2(0,0)
var target_position_point : Vector2 = Vector2(0,0)




var arrow_speed = 500;
# Called when the node enters the scene tree for the first time.
func _ready():
	z_index = 100
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func set_target_look_point(new_target_look_point):
	target_look_point = new_target_look_point
	var direction = (target_look_point - position).normalized()
	rotation = direction.angle() + 45
	

func set_target_position_point(new_target_position_point):
	target_position_point = new_target_position_point
	position = target_position_point
