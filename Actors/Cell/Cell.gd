class_name Cell
extends Node2D

#Signals
signal cell_clicked(cell_instance)
signal cell_mouse_entired(cell_instance)

#Resources
var wall_class = preload("res://Actors/Placeable/Wall/Wall.tscn")
var weight_class = preload("res://Actors/Placeable/Weight/Weight.tscn")

#Components
var cell_sprite : Sprite2D
var cell_border_animator : AnimationPlayer

#Variables 
var cell_type : GameTypes.CellType = GameTypes.CellType.CT_FREE
var cell_position : Vector2i
var cell_interaction_type : GameTypes.CellInteractionType

#Objects
var object_instance = null 
# Called when the node enters the scene tree for the first time.
func _ready():
	cell_sprite = get_node("CellSprite");
	cell_border_animator = get_node("AnimationPlayer")
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func set_cell_interaction_type(cell_interaction_type : GameTypes.CellInteractionType):
	if cell_type != GameTypes.CellType.CT_START and cell_type != GameTypes.CellType.CT_FINISH:
		cell_interaction_type = cell_interaction_type
	
func set_cell_type(cell_type : GameTypes.CellType):
	self.cell_type = cell_type
	_update_cell_state()
	
func get_cell_type() -> GameTypes.CellType:
	return self.cell_type

func set_cell_pos(cell_pos : Vector2i):
	self.cell_position = cell_pos

func get_cell_pos() -> Vector2i:
	return self.cell_position

func _update_cell_state():
	if cell_type == GameTypes.CellType.CT_FREE:
		if (not object_instance == null):
			remove_child(object_instance)
			object_instance = null 
	elif cell_type == GameTypes.CellType.CT_WALL:
		if object_instance == null:
			object_instance = wall_class.instantiate()
			object_instance.position = Vector2(8,4)
			add_child(object_instance)
	elif cell_type == GameTypes.CellType.CT_WEIGHT:
		if object_instance == null:
			object_instance = weight_class.instantiate()
			object_instance.position = Vector2(8,4)
			add_child(object_instance)
	elif cell_type == GameTypes.CellType.CT_START:
		cell_sprite.modulate = Color.RED
	elif cell_type == GameTypes.CellType.CT_FINISH:
		cell_sprite.modulate = Color.GREEN
	
# Mouse Events
func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		emit_signal("cell_clicked", self)
		
func _on_area_2d_mouse_entered():
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		emit_signal("cell_mouse_entired", self)
	else:
		cell_border_animator.play("BorderAnimation")
	
func _on_area_2d_mouse_exited():
	cell_border_animator.play("BorderAnimation_existed")
