class_name MapGenerator
extends Node2D

# Resources
var CellScene = load("res://Actors/Cell/Cell.tscn")

# Parameters
var _row : int = 25
var _column : int = 17 
var _cellSize : int = 16

var start_point = Vector2(0, 0) 
var end_point = Vector2(_row - 1, _column - 1)

# Variables
var _cell_map = []

func _ready():
	_spawn_cells()
	
func _spawn_cells():
	for i in range(_row):
		var CellArray = []
		for j in range(_column):
			var cell : Cell = CellScene.instantiate()
			add_child(cell)
			cell.position = Vector2(i * _cellSize, j * _cellSize)
			CellArray.append(cell)
			if Vector2(i, j) == start_point:
				cell.set_cell_type(GameTypes.CellType.CT_START)
			elif Vector2(i, j) == end_point:
				cell.set_cell_type(GameTypes.CellType.CT_FINISH)
			else:
				cell.set_cell_type(GameTypes.CellType.CT_FREE) 
				cell.connect("cell_clicked", Callable(self, "on_cell_clicked"))
			cell.set_cell_pos(Vector2(i, j))
		_cell_map.append(CellArray)
		
func clear_walls():
	for i in range(0, _cell_map.size()):
		for j in range(0, _cell_map[i].size()):
			var cell = _cell_map[i][j]
			var cell_type : GameTypes.CellType = cell.get_cell_type()
			if cell_type == GameTypes.CellType.CT_WALL:
				cell.set_cell_type(GameTypes.CellType.CT_FREE)
				
				

func get_map_cells():
	return _cell_map

####################################### TO REMOVE
func on_cell_clicked(cell_instance):
	var cell_pos : Vector2i = cell_instance.get_cell_pos()
	var cell_type : GameTypes.CellType = cell_instance.get_cell_type()
	
	if cell_type == GameTypes.CellType.CT_FREE:
		cell_instance.set_cell_type(GameTypes.CellType.CT_WALL)
	elif cell_type == GameTypes.CellType.CT_WALL:
		cell_instance.set_cell_type(GameTypes.CellType.CT_FREE)
