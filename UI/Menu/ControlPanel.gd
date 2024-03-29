extends Control

#Signals
signal start_search_call(SearchSettings)
signal path_clear_call()
signal clear_walls_call()
signal set_map_interaction_type_call(InteractionType)

#Components
var search_button : Button
var clear_walls_button : Button
var clear_path : Button
var speed_slider : HSlider

#Variables
var ControlPanelInfo = {"manhattan": false, "visualisation_frequency" : 0.1, "algorithm_type": GameTypes.SearchAlgorithmType.SAT_A_STAR, "heuristic_function_type": GameTypes.HeuristicFunctionType.HCT_Manhattan}

func _ready():
	search_button = get_node("Menu/VBoxContainer/StartSearchButton")
	
	
func _on_start_search_button_pressed():
	emit_signal("start_search_call",  ControlPanelInfo)
	search_button.disabled = true

func _on_game_controller_search_completed():
	search_button.disabled = false 	

func _on_algorithm_selector_item_selected(index):
	if index == 0:
		ControlPanelInfo["algorithm_type"] = GameTypes.SearchAlgorithmType.SAT_A_STAR
	elif index == 1:
		ControlPanelInfo["algorithm_type"] = GameTypes.SearchAlgorithmType.SAT_DIJKSTRA
	elif index == 2: 
		ControlPanelInfo["algorithm_type"] = GameTypes.SearchAlgorithmType.SAT_BREADTH_FIRST_SEARCH
	elif index == 3: 
		ControlPanelInfo["algorithm_type"] = GameTypes.SearchAlgorithmType.SAT_DEEP_FIRST_SEARCH
		
func _on_euristic_function_selector_item_selected(index):
	if index == 0:
		ControlPanelInfo["heuristic_function_type"] = GameTypes.HeuristicFunctionType.HCT_Manhattan
	elif index == 1:
		ControlPanelInfo["heuristic_function_type"] = GameTypes.HeuristicFunctionType.HCT_Manhattan
	elif index == 2:
		ControlPanelInfo["heuristic_function_type"] = GameTypes.HeuristicFunctionType.HCT_Chebyshev

func _on_clear_path_button_pressed():
	emit_signal("path_clear_call")

func _on_clear_walls_button_pressed():
	emit_signal("clear_walls_call")

func _on_object_palette_item_selected(index):
	var mouse_interaction_type : GameTypes.MapMouseInteractionType
	
	if index == 0:
		mouse_interaction_type = GameTypes.MapMouseInteractionType.IT_PLACING_WALL
	elif index == 1:
		mouse_interaction_type = GameTypes.MapMouseInteractionType.IT_PLACING_WEIGHT
	elif index ==2:
		mouse_interaction_type = GameTypes.MapMouseInteractionType.IT_CLEARING
	
	emit_signal("set_map_interaction_type_call", mouse_interaction_type)
