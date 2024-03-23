class_name MapSpawner
extends Node2D

enum HeuristicCalculateType {HCT_Euclidean, HCT_Manhattan}

signal finding_start()
signal finding_end()
signal cell_map_filled(cell_map)
var CellScene = load("res://Actors/Cell/Cell.tscn")

const _row : int = 24
const _column : int = 16 
const _cellSize : int = 16

const start_point = Vector2i(0, 0) 
const end_point = Vector2i(_row - 1, _column - 1)

var CellMap = []

func _ready():
	var num1 = 24
	num1 = "24"
	print(num1)
	
	_spawn_cells()
"res://Assets/Sprout Lands - Sprites - Basic pack/Tilesets/Grass.png"
func _spawn_cells():
	for i in range(_row):
		var CellArray = []
		for j in range(_column):
			var cell = CellScene.instantiate()
			add_child(cell)
			cell.position = Vector2(i * _cellSize, j * _cellSize)
			CellArray.append(cell)
			
			if Vector2i(i, j) == start_point:
				cell.set_cell_type(Cell.CellType.CT_START)
			elif Vector2i(i, j) == end_point:
				cell.set_cell_type(Cell.CellType.CT_FINISH)
			else:
				cell.set_cell_type(Cell.CellType.CT_FREE) 
				cell.connect("cell_clicked", Callable(self, "on_cell_clicked"))
			cell.set_cell_pos(Vector2i(i, j))
		CellMap.append(CellArray)
		
func _clear_field():
	for i in range(0, CellMap.size()):
		for j in range(0, CellMap[i].size()):
			var cell = CellMap[i][j]
			var cell_type : Cell.CellType = cell.get_cell_type()
			if cell_type == Cell.CellType.CT_FINISH:
				cell.set_cell_type(Cell.CellType.CT_FINISH)
			if cell_type == Cell.CellType.CT_START:
				cell.set_cell_type(Cell.CellType.CT_START)
			else:
				cell.set_cell_type(Cell.CellType.CT_FREE)
			
func on_cell_clicked(cell_instance):
	var cell_pos : Vector2i = cell_instance.get_cell_pos()
	var cell_type : Cell.CellType = cell_instance.get_cell_type()
	
	if cell_type == Cell.CellType.CT_FREE:
		cell_instance.set_cell_type(Cell.CellType.CT_WALL)
	elif cell_type == Cell.CellType.CT_WALL:
		cell_instance.set_cell_type(Cell.CellType.CT_FREE)
	 
func draw_path(path):
	var line = Line2D.new()
	var paked_points = PackedVector2Array()
	
	var index = 0;
	for point in path:
		var cell = CellMap[point.x][point.y]
		var position = Vector2(cell.position.x + 8, cell.position.y + 8)
		paked_points.append(position)
		
		
	line.width /= 5
	line.points = paked_points
	var ggg = Gradient.new()
	ggg.set_color(0, Color.RED)
	ggg.set_color(1, Color.GREEN)
	line.gradient = ggg 
	add_child(line)
	print(line.get_point_count())

func find_path(bManhattan):
	var VisitedPoints = []
	var VisitQueue = PriorityQueue.new()
	var VisitorsDict = {}
	VisitQueue.push(start_point, 0)
	
	while not VisitQueue.is_empty():
		var result = []
		var currentPoint = VisitQueue.pop() # Берем первую точку из очереди 
		var cell = CellMap[currentPoint.x][currentPoint.y] 
		cell.set_cell_interaction_type(Cell.CellInteractionType.CIT_CONSIDERING_CURRENT)
		await get_tree().create_timer(0.1).timeout
		
		
		
		
		cell.set_cell_interaction_type(Cell.CellInteractionType.CIT_CONSIDERED)
		
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
							var cellType : Cell.CellType = cellInstance.get_cell_type()
							if cellType != Cell.CellType.CT_WALL:
								cell = CellMap[nextPoint.x][nextPoint.y]
								cell.set_cell_interaction_type(Cell.CellInteractionType.CIT_CONSIDERING)
								
								VisitQueue.push(nextPoint, heuristic_distance(nextPoint, end_point, HeuristicCalculateType.HCT_Manhattan))
								
								VisitorsDict[nextPoint] = currentPoint
								VisitedPoints.push_back(nextPoint)
								await get_tree().create_timer(0.01).timeout
								
								
	
	emit_signal("finding_end")
	print("Нельзя построить путь")
	return [];	
		


func heuristic_distance(start_point : Vector2i, target_point : Vector2i, heuristicCalculateType) -> float:
	if heuristicCalculateType == HeuristicCalculateType.HCT_Euclidean:
		return sqrt(pow(start_point.x - end_point.x, 2) + pow(start_point.y - end_point.y, 2))
	elif heuristicCalculateType == HeuristicCalculateType.HCT_Manhattan:
		return abs(start_point.x - target_point.x) + abs(start_point.y -target_point.y)
	return 0.0
	


func _on_control_panel_start_search_call(SearchSettings):
	find_path(SearchSettings["manhattan"])
