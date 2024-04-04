class_name GameController
extends Node2D

#Signals
signal search_completed()
signal search_started()
signal maze_generation_completed_call()

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
	_search(SearchSettings)
	
func _on_control_panel_clear_walls():
	map_generator.clear_walls()

func _compare_search(SearchSettings):
	emit_signal("search_started")
	
	
	emit_signal("search_complited")

func _search(SearchSettings):
	emit_signal("search_started")
	
	var find_path_request = {"algorithm_type": SearchSettings["algorithm_type"], "heuristic_function_type": SearchSettings["heuristic_function_type"], "cell_map": cell_map, "start_point": map_generator.start_point , "end_point": map_generator.end_point}
	var find_path_result = PathFinder.find_path(find_path_request)
	
	var is_success = find_path_result["is_success"]
	if is_success:
		await path_search_visualiser.visualise_search(find_path_result["search_sequence"])

		await path_search_visualiser.clear_visualizer()
		await get_tree().create_timer(0.4).timeout
	
		await path_drawer.draw_path(find_path_result["path"], Color.AQUA, Vector2(8, 8))
	
	emit_signal("search_completed")
	
func _on_map_interaction_controller_map_enviroment_changed():
	pass
	
func _clear_components():
	path_search_visualiser.clear_visualizer()
	path_drawer.clear_path()

func _on_control_panel_clear_walls_call():
	map_generator.clear_walls()

func _on_control_panel_path_clear_call():
	_clear_components()

func _on_control_panel_generate_maze_call():
	MazeGenerator.generate_maze_on_map(cell_map)
	await get_tree().create_timer(0.5).timeout
	emit_signal("maze_generation_completed_call")
