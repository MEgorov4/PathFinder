class_name MapInteractionController
extends Node

#Signals
signal map_enviroment_changed()
#Types
enum MapMouseInteractionType { IT_CLEARING, IT_PLACING }

#variables
var interaction_type : MapMouseInteractionType

func setup_controller(cell_map):
	_setup_callbacks(cell_map)
	
func _setup_callbacks(cell_map):
	for cell_array in cell_map:
		for cell : Cell in cell_array:
			cell.cell_clicked.connect(Callable(self, "cell_clicked"))
			cell.cell_mouse_entired.connect(Callable(self, "cell_mouse_entired"))


func cell_clicked(cell : Cell):
	if cell.get_cell_type() == GameTypes.CellType.CT_FREE:
		interaction_type = MapMouseInteractionType.IT_PLACING
		cell.set_cell_type(GameTypes.CellType.CT_WALL)
		emit_signal("map_enviroment_changed")
	elif cell.get_cell_type() == GameTypes.CellType.CT_WALL:
		interaction_type = MapMouseInteractionType.IT_CLEARING
		cell.set_cell_type(GameTypes.CellType.CT_FREE)
		emit_signal("map_enviroment_changed")


func cell_mouse_entired(cell : Cell):
	if interaction_type == MapMouseInteractionType.IT_CLEARING:
		if cell.get_cell_type() == GameTypes.CellType.CT_WALL:
			cell.set_cell_type(GameTypes.CellType.CT_FREE)
			emit_signal("map_enviroment_changed")
	elif interaction_type == MapMouseInteractionType.IT_PLACING:
		if cell.get_cell_type() == GameTypes.CellType.CT_FREE:
			cell.set_cell_type(GameTypes.CellType.CT_WALL)
			emit_signal("map_enviroment_changed")

	
