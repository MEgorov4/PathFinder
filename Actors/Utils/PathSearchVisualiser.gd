class_name SearchVisualiser
extends Node

#Resources
var icon_scene = load("res://Actors/FindingStateIcon/SearchStateIcon.tscn")

#Components
var arrow_agent : ArrowAgent 

#Variables
var cell_map = [[]]
var icons_instances = []


func setup_cells(cell_map):
	self.cell_map = cell_map
	arrow_agent = get_node("ArrowAgent")
	
	
func visualise_search(search_sequence):
	for search_point in search_sequence:
		for search_key : Cell in search_point:
			arrow_agent.set_target_position(search_key.position)
			var search_neibours = search_point[search_key]
			
			await get_tree().create_timer(0.1).timeout
			
			for neibour : Cell in search_neibours:
				var icon_instance : Icon = icon_scene.instantiate()
				icons_instances.push_back(icon_instance);
				
				icon_instance.show_icon("considering")
				icon_instance.position = neibour.position + Vector2(8, 4)
				
				arrow_agent.set_target_rotation(neibour.position)
				
				await get_tree().create_timer(0.1).timeout
				
func clear_visualizer():
	icons_instances.clear()


