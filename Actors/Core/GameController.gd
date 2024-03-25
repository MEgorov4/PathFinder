class_name GameController
extends Node2D


#Components
var map_generator : MapGenerator
var path_finder : PathFinder
var path_drawer : PathDrawer


# Called when the node enters the scene tree for the first time.
func _ready():
	map_generator = get_node("Base/MapSpawner")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
