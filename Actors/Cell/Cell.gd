class_name Cell
extends Node2D

enum CellType {CT_FREE = 0, CT_WALL = 1, CT_START = 2, CT_FINISH = 3}
enum CellInteractionType {CIT_FREE = 0, CIT_CONSIDERING = 1, CIT_CONSIDERED = 2, CIT_CONSIDERING_CURRENT}
signal cell_clicked(cell_instance)

var bCanChange = false;
var sprite : Sprite2D

var cellType : CellType = CellType.CT_FREE

var cellPos : Vector2i

var cellInteractionType : CellInteractionType
# Called when the node enters the scene tree for the first time.
func _ready():
	sprite = get_node("CellSprite");


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_cell_interaction_type(cell_interaction_type : CellInteractionType):
	cellInteractionType = cell_interaction_type
	_update_cell_interaction_state()
	

func set_cell_type(cell_type : CellType):
	cellType = cell_type
	_update_cell_state()
	
func get_cell_type() -> CellType:
	return cellType

func set_cell_pos(cell_pos : Vector2i):
	cellPos = cell_pos

func get_cell_pos() -> Vector2i:
	return cellPos

func _update_cell_state():
	if cellType == CellType.CT_FREE:
		sprite.modulate = Color.GHOST_WHITE
	elif cellType == CellType.CT_WALL:
		sprite.modulate = Color.DIM_GRAY
	elif cellType == CellType.CT_START:
		sprite.modulate = Color.RED
	elif cellType == CellType.CT_FINISH:
		sprite.modulate = Color.GREEN
	
func _update_cell_interaction_state():
	if cellInteractionType == CellInteractionType.CIT_CONSIDERED:
		sprite.modulate = Color.AQUAMARINE
	elif cellInteractionType == CellInteractionType.CIT_CONSIDERING:
		sprite.modulate = Color.SPRING_GREEN   
	elif cellInteractionType == CellInteractionType.CIT_CONSIDERING_CURRENT:
		sprite.modulate = Color.ROYAL_BLUE

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		emit_signal("cell_clicked", self)
		


func _on_area_2d_mouse_entered():
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		emit_signal("cell_clicked", self)
	
