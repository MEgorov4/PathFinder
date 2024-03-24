extends Control


signal start_search_call(SearchSettings)
signal clear_walls()
var ControlPanelInfo = {"manhattan": false, "visualisation_frequency" : 0.1}


var search_button
var speed_slider : HSlider


func _ready():
	search_button = get_node("MarginContainer/VBoxContainer/Button")
	speed_slider = get_node("MarginContainer/VBoxContainer/HBoxContainer2/HSlider")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_start_search_button_pressed():
	ControlPanelInfo["visualisation_frequency"] = speed_slider.value
	emit_signal("start_search_call",  ControlPanelInfo)
	search_button.disabled = true


func _on_map_spawner_finding_end():
	search_button.disabled = false 	


func _on_check_box_toggled(toggled_on):
	ControlPanelInfo["manhattan"] = toggled_on


func _on_button_2_pressed():
	emit_signal("clear_walls")
