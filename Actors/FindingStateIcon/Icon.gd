class_name Icon
extends Node2D

var enabled : bool
var icon_types = {"considering" : load("res://Resources/Images/icons/Question.tres"), "considered" : load("res://Resources/Images/icons/SearchedPoint.tres"), "current_consider": load("res://Resources/Images/icons/invisible.tres")}
var icon_sprite : Sprite2D
var animation_player : AnimationPlayer 

func _ready():
	animation_player = get_node("AnimationPlayer")
	icon_sprite = get_node("Icon")

func _process(delta):
	pass

func show_icon(icon_type):
	icon_sprite.texture = icon_types[icon_type]
	animation_player.play("icon_spawn_animation")
	enabled = true;

func destroy_icon():
	animation_player.play("icon_destroy_animation")
	enabled = false;
