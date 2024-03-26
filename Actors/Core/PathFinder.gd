class_name PathFinder
extends RefCounted

static func find_path(find_request_data):
	var find_result_data = {"is_success": false, "path" : [], "search_sequence" : [{}]}
	
	var algorithm_type : GameTypes.SearchAlgorithmType = find_request_data["algorithm_type"]
	var heuristic_function_type : GameTypes.HeuristicFunctionType = find_request_data["heuristic_function_type"]
	
	var cell_map = find_request_data["cell_map"]
	var start_point : Vector2i = find_request_data["start_point"]
	var end_point : Vector2i = find_request_data["end_point"] 
	
	if algorithm_type == GameTypes.SearchAlgorithmType.SAT_A_STAR:
		find_result_data = _a_star_search(cell_map, start_point, end_point, heuristic_function_type)
	elif algorithm_type == GameTypes.SearchAlgorithmType.SAT_BREADTH_FIRST_SEARCH:
		find_result_data = _breadth_first_search(cell_map, start_point, end_point)
	elif algorithm_type == GameTypes.SearchAlgorithmType.SAT_DEEP_FIRST_SEARCH:
		find_result_data = _deep_fist_search(cell_map, start_point, end_point)
		
	return find_result_data
	
static func _heuristic_function(first_point : Vector2i, second_point : Vector2i, heuristic_function_type : GameTypes.HeuristicFunctionType):
	if heuristic_function_type == GameTypes.HeuristicFunctionType.HCT_Euclidean:
		return sqrt(pow(first_point.x - second_point.x, 2) - pow(first_point.y - second_point.y, 2)) 
	elif heuristic_function_type == GameTypes.HeuristicFunctionType.HCT_Manhattan:
		return abs(first_point.x - second_point.x) + abs(first_point.y - second_point.y)
	
static func _a_star_search(cell_map, start_point : Vector2i, end_point : Vector2i, heuristic_function_type : GameTypes.HeuristicFunctionType):
	###########################################
	var find_result_data = {"is_success": false, "path" : [], "search_sequence" : [{}]}
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
			
			find_result_data["is_success"] = true
			find_result_data["path"] = path
			find_result_data["search_sequence"] = search_sequence
			return find_result_data
			
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
								
								var heuristic_distance = _heuristic_function(current_point, end_point, heuristic_function_type) + (current_point.x + current_point.y) / float(1.4)
									
								to_visit_priority_queue.push(next_point, heuristic_distance)
								
								visitors_dict[next_point] = current_point
								visited.push_back(next_point)
		search_sequence.push_back(search_point_dict)
		
	return find_result_data
	
static func _breadth_first_search(cell_map, start_point : Vector2i, end_point : Vector2i):
	###########################################
	var find_result_data = {"is_success": false, "path" : [], "search_sequence" : [{}]}
	var search_sequence = []
	###########################################
	
	var VisitedPoints = []
	var VisitQueue = []
	var VisitorsDict = {}
	VisitQueue.push_back(start_point)
	
	while not VisitQueue.is_empty():
		var result = []
		var currentPoint = VisitQueue.pop_front()
		var cell = CellMap[currentPoint.x][currentPoint.y] 
		
		arrow_agent.set_target_position(cell.position)
		
		if currentPoint == end_point: 
			
			while(currentPoint != start_point):
				result.push_front(currentPoint)
				currentPoint = VisitorsDict[currentPoint]
			result.push_front(start_point)
			
			return result
			
		for x in range(-1, 2):
			for y in range(-1, 2):
				if abs(x) != abs(y):
					var nextPoint = Vector2i(currentPoint.x  + x, currentPoint.y + y)
					if (nextPoint.x >= 0 and nextPoint.x < CellMap.size()) && (nextPoint.y >= 0 and nextPoint.y < CellMap[nextPoint.x].size()):
						if not (Vector2i(nextPoint.x, nextPoint.y) in VisitedPoints):
							var cellInstance = CellMap[nextPoint.x][nextPoint.y]
							if cellInstance.get_cell_type() != GameTypes.CellType.CT_WALL:
								cell = CellMap[nextPoint.x][nextPoint.y]
								
								arrow_agent.set_target_rotation(cell.position)
								
								VisitQueue.push_back(nextPoint)
								
								VisitorsDict[nextPoint] = currentPoint
								VisitedPoints.push_back(nextPoint)
								
static func _deep_fist_search(cell_map, start_point : Vector2i, end_point : Vector2i):
	pass; 


func breadth_search():

	
func deep_search(bManhattan):
	var VisitedPoints = []
	var VisitQueue = []
	var VisitorsDict = {}
	VisitQueue.push_front(start_point)
	
	while not VisitQueue.is_empty():
		var result = []
		var currentPoint = VisitQueue.pop_front()
		var cell = CellMap[currentPoint.x][currentPoint.y] 
		cell.set_cell_interaction_type(GameTypes.CellInteractionType.CIT_CONSIDERING_CURRENT)
		arrow_agent.set_target_position(cell.position)
		await get_tree().create_timer(0.1).timeout
		cell.set_cell_interaction_type(GameTypes.CellInteractionType.CIT_CONSIDERED)
		if currentPoint == end_point: 
			print("Можно построить путь")
			while(currentPoint != start_point):
				result.push_front(currentPoint)
				currentPoint = VisitorsDict[currentPoint]
			draw_path(result)
			emit_signal("finding_end")
			return result
			
		for x in range(-1, 2):
			for y in range(-1, 2):
				if abs(x) != abs(y):
					var nextPoint = Vector2i(currentPoint.x  + x, currentPoint.y + y)
					if (nextPoint.x >= 0 and nextPoint.x < CellMap.size()) && (nextPoint.y >= 0 and nextPoint.y < CellMap[nextPoint.x].size()):
						var cellInstance = CellMap[nextPoint.x][nextPoint.y]
						if not (Vector2i(nextPoint.x, nextPoint.y) in VisitedPoints):
							var cellType : GameTypes.CellType = cellInstance.get_cell_type()
							if cellType != GameTypes.CellType.CT_WALL:
								cell = CellMap[nextPoint.x][nextPoint.y]
								cell.set_cell_interaction_type(GameTypes.CellInteractionType.CIT_CONSIDERING)
								arrow_agent.set_target_rotation(cell.position)
								
								VisitQueue.push_front(nextPoint)
								
								VisitorsDict[nextPoint] = currentPoint
								VisitedPoints.push_back(nextPoint)
								await get_tree().create_timer(0.1).timeout
