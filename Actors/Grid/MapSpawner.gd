class_name MapGenerator
extends Node2D

signal finding_start()
signal finding_end()
signal cell_map_filled(cell_map)

var CellScene = load("res://Actors/Cell/Cell.tscn")

const _row : int = 25
const _column : int = 17 
const _cellSize : int = 16

const start_point = Vector2i(0, 0) 
const end_point = Vector2i(_row - 1, _column - 1)

var CellMap = []

var path_drawer : PathDrawer

var arrow_agent 

func _ready():
	path_drawer = get_node("PathDrawer")
	arrow_agent = get_node ("ArrowAgent")
	path_drawer.z_index = 100
	_spawn_cells()
	
func _spawn_cells():
	for i in range(_row):
		var CellArray = []
		for j in range(_column):
			var cell : Cell = CellScene.instantiate()
			add_child(cell)
			cell.position = Vector2(i * _cellSize, j * _cellSize)
			CellArray.append(cell)
			if Vector2i(i, j) == start_point:
				cell.set_cell_type(GameTypes.CellType.CT_START)
			elif Vector2i(i, j) == end_point:
				cell.set_cell_type(GameTypes.CellType.CT_FINISH)
			else:
				cell.set_cell_type(GameTypes.CellType.CT_FREE) 
				cell.connect("cell_clicked", Callable(self, "on_cell_clicked"))
			cell.set_cell_pos(Vector2i(i, j))
		CellMap.append(CellArray)
		
func _clear_field():
	for i in range(0, CellMap.size()):
		for j in range(0, CellMap[i].size()):
			var cell = CellMap[i][j]
			var cell_type : GameTypes.CellType = cell.get_cell_type()
			if cell_type == GameTypes.CellType.CT_FINISH:
				cell.set_cell_type(GameTypes.CellType.CT_FINISH)
			if cell_type == GameTypes.CellType.CT_START:
				cell.set_cell_type(GameTypes.CellType.CT_START)
			else:
				cell.set_cell_type(GameTypes.CellType.CT_FREE)
func _clear_walls():
	for i in range(0, CellMap.size()):
		for j in range(0, CellMap[i].size()):
			var cell = CellMap[i][j]
			var cell_type : GameTypes.CellType = cell.get_cell_type()
			if cell_type == GameTypes.CellType.CT_WALL:
				cell.set_cell_type(GameTypes.CellType.CT_FREE)
func _clear_path():
	path_drawer.clear_path()
	for i in range(0, CellMap.size()):
		for j in range(0, CellMap[i].size()):
			var cell : Cell = CellMap[i][j]
			if cell.search_icon.enabled:
				cell.search_icon.destroy_icon()
func on_cell_clicked(cell_instance):
	var cell_pos : Vector2i = cell_instance.get_cell_pos()
	var cell_type : GameTypes.CellType = cell_instance.get_cell_type()
	
	if cell_type == GameTypes.CellType.CT_FREE:
		cell_instance.set_cell_type(GameTypes.CellType.CT_WALL)
	elif cell_type == GameTypes.CellType.CT_WALL:
		cell_instance.set_cell_type(GameTypes.CellType.CT_FREE)
	 


func _on_control_panel_start_search_call(SearchSettings):
	_clear_path()
	
	var find_request = {"algorithm_type" : GameTypes.SearchAlgorithmType.SAT_A_STAR, "heuristic_function_type": GameTypes.HeuristicFunctionType.HCT_Manhattan,"cell_map" : CellMap, "start_point" : start_point, "end_point" : end_point}
	var find_response = PathFinder.find_path(find_request)
	print(find_response["search_sequence"])
	path_drawer.path_add_point_timeout = 0.01
	path_drawer.draw_path(find_response["path"], Vector2(8,8))

func _on_control_panel_clear_walls():
	_clear_walls()
