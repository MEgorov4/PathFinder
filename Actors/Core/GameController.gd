class_name GameController
extends Node2D

#Signals
signal search_completed()
signal search_started()

#Components
var map_generator : MapGenerator
var path_drawer : PathDrawer
var path_search_visualiser : SearchVisualiser
var map_interaction_controller : MapInteractionController

#Variables
var cell_map

# Called when the node enters the scene tree for the first time.
func _ready():
	map_generator = get_node("Base/MapSpawner")
	cell_map = map_generator.get_map_cells()
		
	map_interaction_controller = get_node("MapInteractionController")
	map_interaction_controller.setup_controller(map_generator.get_map_cells())
	
	path_drawer = get_node("PathDrawer")
	path_drawer.z_index = 100
	
	path_search_visualiser = get_node("PathSearchVisaliser")
	
	path_search_visualiser.setup_cells(map_generator.get_map_cells())
	
	
func _on_control_panel_start_search_call(SearchSettings):
	_clear_components()
	_search()
	
func _on_control_panel_clear_walls():
	map_generator.clear_walls()

func _search():
	emit_signal("search_started")
	
	var find_path_request = {"algorithm_type": GameTypes.SearchAlgorithmType.SAT_A_STAR, "heuristic_function_type": GameTypes.HeuristicFunctionType.HCT_Manhattan, "cell_map": cell_map, "start_point": map_generator.start_point , "end_point": map_generator.end_point}
	var find_path_result = PathFinder.find_path(find_path_request)
	
	
	await path_search_visualiser.visualise_search(find_path_result["search_sequence"])
	
	
	await path_search_visualiser.clear_visualizer()
	await get_tree().create_timer(0.4).timeout
	
	await path_drawer.draw_path(find_path_result["path"], Vector2(8, 8))
	
	emit_signal("search_completed")
	
func _on_map_interaction_controller_map_enviroment_changed():
	pass
	
func _clear_components():
	path_search_visualiser.clear_visualizer()
	path_drawer.clear_path()

