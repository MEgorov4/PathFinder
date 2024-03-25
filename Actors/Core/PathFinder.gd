class_name PathFinder
extends RefCounted

static func find_path(find_request_data):
	var find_result_data = { "is_aborted" : false, "is_success": false, "path" : [], "search_sequence" : [{}]}
	
	var algorithm_type : GameTypes.SearchAlgorithmType = find_request_data["algorithm_type"]
	var heuristic_function_type : GameTypes.HeuristicFunctionType = find_request_data["heueristic_function_type"]
	
	var cell_map = find_request_data["cell_map"]
	var start_point : Vector2i = find_request_data["start_point"]
	var end_point : Vector2i = find_request_data["end_point"] 
	
	if algorithm_type == GameTypes.SearchAlgorithmType.SAT_A_STAR:
		find_result_data = _a_star_search(cell_map, heuristic_function_type)
	elif algorithm_type == GameTypes.SearchAlgorithmType.SAT_BREADTH_FIRST_SEARCH:
		find_result_data = _breadth_first_search(cell_map)
	elif algorithm_type == GameTypes.SearchAlgorithmType.SAT_DEEP_FIRST_SEARCH:
		find_result_data = _deep_fist_search(cell_map)
	
static func _heuristic_function(first_point : Vector2i, second_point : Vector2i, heuristic_function_type : GameTypes.HeuristicFunctionType):
	if heuristic_function_type == GameTypes.HeuristicFunctionType.HCT_Euclidean:
		return sqrt(pow(first_point.x - second_point.x, 2) - pow(first_point.y - second_point.y, 2)) 
	elif heuristic_function_type == GameTypes.HeuristicFunctionType.HCT_Manhattan:
		return abs(first_point.x - second_point.x) + abs(first_point.y - second_point.y)
	
static func _a_star_search(cell_map, heuristic_function_type : GameTypes.HeuristicFunctionType):
	pass;
	
static func _breadth_first_search(cell_map):
	pass;
	
static func _deep_fist_search(cell_map):
	pass; 
