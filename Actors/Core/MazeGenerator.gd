class_name MazeGenerator
extends RefCounted

static var gizmo_points = []

static func generate_maze_on_map(cell_map):
		for i in range(0, cell_map.size()):
			for j in range(0, cell_map[i].size()):
				var cell : Cell = cell_map[i][j]
				if (not (cell.get_cell_type() == GameTypes.CellType.CT_FINISH || cell.get_cell_type() == GameTypes.CellType.CT_START)):
					cell.set_cell_type(GameTypes.CellType.CT_FREE)
					if (i % 2 != 0 && j % 2 != 0):
						gizmo_points.push_back(Vector2i(cell.get_cell_pos()))
		while gizmo_points.size() > 0:
			var gizmo_point : Vector2i = gizmo_points.pop_back()
			generate_wall_sequence_from_point(gizmo_point, cell_map)
			
static func generate_wall_sequence_from_point(point, cell_map):
	var distance : Vector2i = get_random_distance()
	var current_point : Vector2i = point
	
	while(current_point.x >= 0 && current_point.x < cell_map.size() && current_point.y >= 0 && current_point.y < cell_map[current_point.x].size()):
		if(current_point != point && current_point.x % 2 !=0 && current_point.y % 2 != 0):
			break
		
		cell_map[current_point.x][current_point.y].set_cell_type(GameTypes.CellType.CT_WALL)
		current_point = current_point + distance
		
static func get_random_distance() -> Vector2i:
	var distances = [Vector2i(1,0), Vector2i(-1, 0), Vector2i(0, 1), Vector2i(0, -1)]
	return distances[randi_range(0, 3)]
