class_name SearchVisualiser
extends Node

#Resources
var icon_scene = load("res://Actors/FindingStateIcon/SearchStateIcon.tscn")

#Components
var arrow_agent : ArrowAgent 

#Variables
var cell_map = [[]]
var icons_instances = {}


func setup_cells(cell_map):
	self.cell_map = cell_map
	arrow_agent = get_node("ArrowAgent")
	clear_visualizer()
	
	
func visualise_search(search_sequence):
	for search_point in search_sequence:
		for search_key : Cell in search_point.keys():
			if search_key.get_cell_pos() in icons_instances:
				icons_instances[search_key.get_cell_pos()].destroy_icon()
				icons_instances.erase(search_key)
			arrow_agent.set_target_position(search_key.position + Vector2(-8, -8))
			var search_neibours = search_point[search_key]
			
			await get_tree().create_timer(0.005).timeout
			
			for neibour : Cell in search_neibours:
				var icon_instance = icon_scene.instantiate()  
				add_child(icon_instance)  
				icons_instances[neibour.get_cell_pos()] = icon_instance
				var icon_instance_script = icon_instance as Icon  
				
				
				icon_instance_script.show_icon("considering")
				icon_instance_script.position = neibour.position
				
				arrow_agent.set_target_rotation(neibour.position)
				
				await get_tree().create_timer(0.005).timeout
				
func clear_visualizer():
	arrow_agent.position = Vector2(-200, -200)
	for key in icons_instances:
		remove_child(icons_instances[key])
	


