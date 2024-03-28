extends Control

signal start_search_call(SearchSettings)
signal path_clear_call()
signal clear_walls_call()

#Components
var search_button : Button
var clear_walls_button : Button
var clear_path : Button
var speed_slider : HSlider

#Variables
var ControlPanelInfo = {"manhattan": false, "visualisation_frequency" : 0.1}

func _ready():
	search_button = get_node("MarginContainer/VBoxContainer/StartSearchButton")
	
	
func _on_start_search_button_pressed():
	emit_signal("start_search_call",  ControlPanelInfo)
	search_button.disabled = true

func _on_game_controller_search_completed():
	search_button.disabled = false 	

func _on_algorithm_selector_item_selected(index):
	if index == 0:
		ControlPanelInfo["algorithm_type"] = GameTypes.SearchAlgorithmType.SAT_A_STAR
	elif index == 2: 
		ControlPanelInfo["algorithm_type"] = GameTypes.SearchAlgorithmType.SAT_BREADTH_FIRST_SEARCH
	elif index == 3: 
		ControlPanelInfo["algorithm_type"] = GameTypes.SearchAlgorithmType.SAT_DEEP_FIRST_SEARCH
		
func _on_euristic_function_selector_item_selected(index):
	if index == 0:
		ControlPanelInfo["heuristic_function_type"] = GameTypes.HeuristicFunctionType.HCT_Manhattan
	elif index == 1:
		ControlPanelInfo["heuristic_function_type"] = GameTypes.HeuristicFunctionType.HCT_Manhattan

func _on_clear_path_button_pressed():
	emit_signal("path_clear_call")

func _on_clear_walls_button_pressed():
	emit_signal("clear_walls_call")







