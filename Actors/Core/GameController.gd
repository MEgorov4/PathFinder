class_name GameController
extends Node2D

#Signals
signal search_completed()

#Components
var map_generator : MapGenerator
var path_drawer : PathDrawer

#Variables
var cell_map

# Called when the node enters the scene tree for the first time.
func _ready():
	map_generator = get_node("Base/MapSpawner")
	cell_map = map_generator.get_map_cells()
	
	path_drawer = get_node("PathDrawer")
	path_drawer.z_index = 100
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_control_panel_start_search_call(SearchSettings):
	var find_path_request = {"algorithm_type": GameTypes.SearchAlgorithmType.SAT_A_STAR, "heuristic_function_type": GameTypes.HeuristicFunctionType.HCT_Euclidean, "cell_map": cell_map, "start_point": map_generator.start_point , "end_point": map_generator.end_point}
	
	var find_path_result = PathFinder.find_path(find_path_request)
	
	path_drawer.draw_path(find_path_result["path"], Vector2(8, 8))
	
	emit_signal("search_complited")

func _on_control_panel_clear_walls():
	map_generator.clear_walls()
