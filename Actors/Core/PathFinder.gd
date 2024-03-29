class_name PathFinder
extends RefCounted

static func find_path(find_request_data):
	var find_path_data_result = {"is_success": false, "path" : [], "search_sequence" : [{}]}
	
	var algorithm_type : GameTypes.SearchAlgorithmType = find_request_data["algorithm_type"]
	var heuristic_function_type : GameTypes.HeuristicFunctionType = find_request_data["heuristic_function_type"]
	
	var cell_map = find_request_data["cell_map"]
	var start_point : Vector2i = find_request_data["start_point"]
	var end_point : Vector2i = find_request_data["end_point"] 
	
	if algorithm_type == GameTypes.SearchAlgorithmType.SAT_A_STAR:
		find_path_data_result = _a_star_search(cell_map, start_point, end_point, heuristic_function_type)
	elif algorithm_type == GameTypes.SearchAlgorithmType.SAT_DIJKSTRA:
		find_path_data_result = _dijkstra(cell_map, start_point, end_point)
	elif algorithm_type == GameTypes.SearchAlgorithmType.SAT_BREADTH_FIRST_SEARCH:
		find_path_data_result = _breadth_first_search(cell_map, start_point, end_point)
	elif algorithm_type == GameTypes.SearchAlgorithmType.SAT_DEEP_FIRST_SEARCH:
		find_path_data_result = _deep_fist_search(cell_map, start_point, end_point)
		
	return find_path_data_result
	
static func _heuristic_function(first_point : Vector2i, second_point : Vector2i, heuristic_function_type : GameTypes.HeuristicFunctionType):
	if heuristic_function_type == GameTypes.HeuristicFunctionType.HCT_Euclidean:
		return sqrt(pow(first_point.x - second_point.x, 2) - pow(first_point.y - second_point.y, 2)) 
	elif heuristic_function_type == GameTypes.HeuristicFunctionType.HCT_Manhattan:
		return abs(first_point.x - second_point.x) + abs(first_point.y - second_point.y)
	elif heuristic_function_type == GameTypes.HeuristicFunctionType.HCT_Chebyshev:
		return max(second_point.x - first_point.x, second_point.y - first_point.y)
	
static func _get_count_steps_before(start_point, current_point, point_link_map):
	var counter = 0
	while start_point != current_point:
		current_point = point_link_map[current_point]
		counter += 1
	print(counter)
	return counter
	
	
static func _a_star_search(cell_map, start_point : Vector2i, end_point : Vector2i, heuristic_function_type : GameTypes.HeuristicFunctionType):
	###########################################
	var find_path_data_result = {"is_success": false, "path" : [], "search_sequence" : [{}]}
	var search_sequence = []
	###########################################
	var visited = []
	var to_visit_priority_queue = PriorityQueue.new()
	var visitors_dict = {}
	
	to_visit_priority_queue.push(start_point, 0)
	visited.push_back(start_point)
	while not to_visit_priority_queue.is_empty():
		var path = []
		var current_point = to_visit_priority_queue.pop()
		
		######################################
		var current_cell_instance = cell_map[current_point.x][current_point.y]
		var search_point_dict = {current_cell_instance: []}
		#######################################
		
		if current_point == end_point: 
			while(current_point != start_point):
				path.push_front(cell_map[current_point.x][current_point.y])
				current_point = visitors_dict[current_point]
			path.push_front(cell_map[current_point.x][current_point.y])
			####################################
			find_path_data_result["is_success"] = true
			find_path_data_result["path"] = path
			find_path_data_result["search_sequence"] = search_sequence
			####################################
			return find_path_data_result
			
		for x in range(-1, 2):
			for y in range(-1, 2):
				if abs(x) != abs(y):
					var next_point = Vector2i(current_point.x  + x, current_point.y + y)
					if (next_point.x >= 0 and next_point.x < cell_map.size()) && (next_point.y >= 0 and next_point.y < cell_map[next_point.x].size()):
						if not (Vector2i(next_point.x, next_point.y) in visited):
							var next_cell_instance = cell_map[next_point.x][next_point.y]
							
							if next_cell_instance.get_cell_type() != GameTypes.CellType.CT_WALL:
								
								############################
								search_point_dict[current_cell_instance].push_back(next_cell_instance)
								############################
								
								visitors_dict[next_point] = current_point
								visited.push_back(next_point)
								var distance = _heuristic_function(current_point, end_point, heuristic_function_type)  + _get_count_steps_before(start_point, next_point , visitors_dict) 
									
								if next_cell_instance.get_cell_type() == GameTypes.CellType.CT_WEIGHT:
									distance += 70
									
								to_visit_priority_queue.push(next_point, distance)
		search_sequence.push_back(search_point_dict)
		
	return find_path_data_result
	
	
static func _dijkstra(cell_map, start_point : Vector2i, end_point : Vector2i):
	###########################################
	var find_path_data_result = {"is_success": false, "path" : [], "search_sequence" : [{}]}
	var search_sequence = []
	###########################################
	var visited = []
	var to_visit_priority_queue = PriorityQueue.new()
	var visitors_dict = {}
	
	to_visit_priority_queue.push(start_point, 0)
	visited.push_back(start_point)
	while not to_visit_priority_queue.is_empty():
		var path = []
		var current_point = to_visit_priority_queue.pop()
		
		######################################
		var current_cell_instance = cell_map[current_point.x][current_point.y]
		var search_point_dict = {current_cell_instance: []}
		#######################################
		
		if current_point == end_point: 
			while(current_point != start_point):
				path.push_front(cell_map[current_point.x][current_point.y])
				current_point = visitors_dict[current_point]
			path.push_front(cell_map[current_point.x][current_point.y])
			####################################
			find_path_data_result["is_success"] = true
			find_path_data_result["path"] = path
			find_path_data_result["search_sequence"] = search_sequence
			####################################
			return find_path_data_result
			
		for x in range(-1, 2):
			for y in range(-1, 2):
				if abs(x) != abs(y):
					var next_point = Vector2i(current_point.x  + x, current_point.y + y)
					if (next_point.x >= 0 and next_point.x < cell_map.size()) && (next_point.y >= 0 and next_point.y < cell_map[next_point.x].size()):
						if not (Vector2i(next_point.x, next_point.y) in visited):
							var next_cell_instance = cell_map[next_point.x][next_point.y]
							
							if next_cell_instance.get_cell_type() != GameTypes.CellType.CT_WALL:
								
								############################
								search_point_dict[current_cell_instance].push_back(next_cell_instance)
								############################
								
								visitors_dict[next_point] = current_point
								visited.push_back(next_point)
								var distance = _get_count_steps_before(start_point, next_point , visitors_dict) 
									
								if next_cell_instance.get_cell_type() == GameTypes.CellType.CT_WEIGHT:
									distance += 70
									
								to_visit_priority_queue.push(next_point, distance)
		search_sequence.push_back(search_point_dict)
		
	return find_path_data_result

static func _breadth_first_search(cell_map, start_point : Vector2, end_point : Vector2):
	###########################################
	var find_path_data_result = {"is_success": false, "path" : [], "search_sequence" : [{}]}
	var search_sequence = []
	###########################################
	
	var VisitedPoints = []
	var VisitQueue = []
	var VisitorsDict = {}
	VisitQueue.push_back(start_point)
	
	while not VisitQueue.is_empty():
		var path = []
		var current_point = VisitQueue.pop_front()

		######################################
		var current_cell_instance = cell_map[current_point.x][current_point.y]
		var search_point_dict = {current_cell_instance: []}
		#######################################
		
		if current_point == end_point: 
			while(current_point != start_point):
				path.push_front(cell_map[current_point.x][current_point.y])
				current_point = VisitorsDict[current_point]
			path.push_front(cell_map[current_point.x][current_point.y])
			
			
			####################################
			find_path_data_result["is_success"] = true
			find_path_data_result["path"] = path
			find_path_data_result["search_sequence"] = search_sequence
			####################################
			return find_path_data_result
			
		for x in range(-1, 2):
			for y in range(-1, 2):
				if abs(x) != abs(y):
					var next_point = Vector2(current_point.x  + x, current_point.y + y)
					if (next_point.x >= 0 and next_point.x < cell_map.size()) && (next_point.y >= 0 and next_point.y < cell_map[next_point.x].size()):
						if not (Vector2(next_point.x, next_point.y) in VisitedPoints):
							var next_cell_instance = cell_map[next_point.x][next_point.y]
							if next_cell_instance.get_cell_type() != GameTypes.CellType.CT_WALL:
								
								############################
								search_point_dict[current_cell_instance].push_back(next_cell_instance)
								############################
								
								VisitQueue.push_back(next_point)
								VisitorsDict[next_point] = current_point
								VisitedPoints.push_back(next_point)
		search_sequence.push_back(search_point_dict)
	return find_path_data_result
								
static func _deep_fist_search(cell_map, start_point : Vector2, end_point : Vector2):
	###########################################
	var find_path_data_result = {"is_success": false, "path" : [], "search_sequence" : [{}]}
	var search_sequence = []
	###########################################
	
	var VisitedPoints = []
	var VisitQueue = []
	var VisitorsDict = {}
	VisitQueue.push_front(start_point)
	
	while not VisitQueue.is_empty():
		var path = []
		var current_point = VisitQueue.pop_front()

		######################################
		var current_cell_instance = cell_map[current_point.x][current_point.y]
		var search_point_dict = {current_cell_instance: []}
		#######################################

		if current_point == end_point: 
			while(current_point != start_point):
				path.push_front(cell_map[current_point.x][current_point.y])
				current_point = VisitorsDict[current_point]
			path.push_front(cell_map[current_point.x][current_point.y])
			####################################
			find_path_data_result["is_success"] = true
			find_path_data_result["path"] = path
			find_path_data_result["search_sequence"] = search_sequence
			####################################
			return find_path_data_result
			
		for x in range(-1, 2):
			for y in range(-1, 2):
				if abs(x) != abs(y):
					var next_point = Vector2(current_point.x  + x, current_point.y + y)
					if (next_point.x >= 0 and next_point.x < cell_map.size()) && (next_point.y >= 0 and next_point.y < cell_map[next_point.x].size()):
						
						if not (Vector2(next_point.x, next_point.y) in VisitedPoints):
							var next_cell_instance = cell_map[next_point.x][next_point.y]
							if next_cell_instance.get_cell_type() != GameTypes.CellType.CT_WALL:
								
								############################
								search_point_dict[current_cell_instance].push_back(next_cell_instance)
								############################
								
								VisitQueue.push_front(next_point)
								VisitorsDict[next_point] = current_point
								VisitedPoints.push_back(next_point)
		search_sequence.push_back(search_point_dict)
	return find_path_data_result
