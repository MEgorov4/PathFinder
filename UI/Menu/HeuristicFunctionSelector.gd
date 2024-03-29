extends OptionButton


var horizontal_box : HBoxContainer 

# Called when the node enters the scene tree for the first time.
func _ready():
	add_item("Manhattan")
	add_item("Euclidean")
	add_item("Cheb`ishev")
	#add_item("Octile")
	horizontal_box = get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_option_button_item_selected(index):
	if index == 0:
		horizontal_box.visible = true
	else:
		horizontal_box.visible = false
