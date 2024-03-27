class_name Cell
extends Node2D


#Signals
signal cell_clicked(cell_instance)
signal cell_mouse_entired(cell_instance)

#Components
var cell_sprite : Sprite2D
var cell_border_animator : AnimationPlayer

#Variables 
var cellType : GameTypes.CellType = GameTypes.CellType.CT_FREE

var cellPos : Vector2i

var cellInteractionType : GameTypes.CellInteractionType

var wall_instance = null 
var wall_class = preload("res://Actors/Wall/Wall.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	cell_sprite = get_node("CellSprite");
	cell_border_animator = get_node("AnimationPlayer")
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func set_cell_interaction_type(cell_interaction_type : GameTypes.CellInteractionType):
	if cellType != GameTypes.CellType.CT_START and cellType != GameTypes.CellType.CT_FINISH:
		cellInteractionType = cell_interaction_type
	
func set_cell_type(cell_type : GameTypes.CellType):
	cellType = cell_type
	_update_cell_state()
	
func get_cell_type() -> GameTypes.CellType:
	return cellType

func set_cell_pos(cell_pos : Vector2i):
	cellPos = cell_pos

func get_cell_pos() -> Vector2i:
	return cellPos

func _update_cell_state():
	if cellType == GameTypes.CellType.CT_FREE:
		if (not wall_instance == null):
			remove_child(wall_instance)
			wall_instance = null 
	elif cellType == GameTypes.CellType.CT_WALL:
		if wall_instance == null:
			wall_instance = wall_class.instantiate()
			wall_instance.position = Vector2(8,4)
			add_child(wall_instance)
			
	elif cellType == GameTypes.CellType.CT_START:
		cell_sprite.modulate = Color.RED
	elif cellType == GameTypes.CellType.CT_FINISH:
		cell_sprite.modulate = Color.GREEN
	
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
