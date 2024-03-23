extends Control


signal start_search_call(SearchSettings)
var ControlPanelInfo = {"manhattan": false}


var search_button



func _ready():
	search_button = get_node("MarginContainer/VBoxContainer/Button")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_start_search_button_pressed():
	emit_signal("start_search_call",  ControlPanelInfo)
	search_button.disabled = true


func _on_map_spawner_finding_end():
	search_button.disabled = false 	


func _on_check_box_toggled(toggled_on):
	ControlPanelInfo["manhattan"] = toggled_on
