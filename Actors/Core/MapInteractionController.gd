class_name MapInteractionController
extends Node

#Signals
signal map_enviroment_changed()
#Types


#variables
var interaction_type : GameTypes.MapMouseInteractionType
var can_modify_map : bool = true

func setup_controller(cell_map):
	_setup_callbacks(cell_map)
	
func _setup_callbacks(cell_map):
	for cell_array in cell_map:
		for cell : Cell in cell_array:
			cell.cell_clicked.connect(Callable(self, "cell_clicked"))
			cell.cell_mouse_entired.connect(Callable(self, "cell_mouse_entired"))


func cell_clicked(cell : Cell):
	if can_modify_map:
		if interaction_type == GameTypes.MapMouseInteractionType.IT_CLEARING:
			if cell.get_cell_type() == GameTypes.CellType.CT_WALL or cell.get_cell_type() == GameTypes.CellType.CT_WEIGHT:
				cell.set_cell_type(GameTypes.CellType.CT_FREE)
				emit_signal("map_enviroment_changed")
		elif interaction_type == GameTypes.MapMouseInteractionType.IT_PLACING_WALL:
			if cell.get_cell_type() == GameTypes.CellType.CT_FREE:
				cell.set_cell_type(GameTypes.CellType.CT_WALL)
				emit_signal("map_enviroment_changed")
		elif interaction_type == GameTypes.MapMouseInteractionType.IT_PLACING_WEIGHT:
			if cell.get_cell_type() == GameTypes.CellType.CT_FREE:
				cell.set_cell_type(GameTypes.CellType.CT_WEIGHT)
				emit_signal("map_enviroment_changed")


func cell_mouse_entired(cell : Cell):
	if can_modify_map:
		if interaction_type == GameTypes.MapMouseInteractionType.IT_CLEARING:
			if cell.get_cell_type() == GameTypes.CellType.CT_WALL or cell.get_cell_type() == GameTypes.CellType.CT_WEIGHT:
				cell.set_cell_type(GameTypes.CellType.CT_FREE)
				emit_signal("map_enviroment_changed")
		elif interaction_type == GameTypes.MapMouseInteractionType.IT_PLACING_WALL:
			if cell.get_cell_type() == GameTypes.CellType.CT_FREE:
				cell.set_cell_type(GameTypes.CellType.CT_WALL)
				emit_signal("map_enviroment_changed")
		elif interaction_type == GameTypes.MapMouseInteractionType.IT_PLACING_WEIGHT:
			if cell.get_cell_type() == GameTypes.CellType.CT_FREE:
				cell.set_cell_type(GameTypes.CellType.CT_WEIGHT)
				emit_signal("map_enviroment_changed")



func _on_game_controller_search_completed():
	can_modify_map = true


func _on_game_controller_search_started():
	can_modify_map = false


func _on_control_panel_set_map_interaction_type_call(interaction_type):
	self.interaction_type = interaction_type
