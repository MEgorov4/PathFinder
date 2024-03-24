class_name Cell
extends Node2D

enum CellType {CT_FREE = 0, CT_WALL = 1, CT_START = 2, CT_FINISH = 3}
enum CellInteractionType {CIT_FREE = 0, CIT_CONSIDERING = 1, CIT_CONSIDERED = 2, CIT_CONSIDERING_CURRENT}
signal cell_clicked(cell_instance)



var animation_player : AnimationPlayer
var particle_system : CPUParticles2D
var audio_player : CellAudioStreamPlayer
var sprite : Sprite2D
var search_icon : Icon

var cellType : CellType = CellType.CT_FREE

var cellPos : Vector2i

var cellInteractionType : CellInteractionType

var wall_instance = null 
var wall_class = preload("res://Actors/Wall/Wall.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	sprite = get_node("CellSprite");
	search_icon = get_node("SearchIcon")
	
	search_icon.z_index = 99
	
	animation_player = get_node("AnimationPlayer")
	particle_system = get_node("PlaceExplosure")
	audio_player = get_node("AudioStreamPlayer")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func set_cell_interaction_type(cell_interaction_type : CellInteractionType):
	if cellType != Cell.CellType.CT_START and cellType != Cell.CellType.CT_FINISH:
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
		if (not wall_instance == null):
			remove_child(wall_instance)
			wall_instance = null 
			audio_player.play_sound_by_name("delete_wall")
		sprite.modulate = Color.GHOST_WHITE
		if(search_icon.enabled):
			search_icon.destroy_icon()
	elif cellType == CellType.CT_WALL:
		if wall_instance == null:
			wall_instance = wall_class.instantiate()
			wall_instance.position = Vector2(8,4)
			add_child(wall_instance)
			particle_system.emitting = true
			audio_player.play_sound_by_name("place_wall")
			if(search_icon.enabled):
				search_icon.destroy_icon()
			
	elif cellType == CellType.CT_START:
		sprite.modulate = Color.RED
	elif cellType == CellType.CT_FINISH:
		sprite.modulate = Color.GREEN
	
func _update_cell_interaction_state():
	if wall_instance == null:
		if cellInteractionType == CellInteractionType.CIT_CONSIDERED:
			search_icon.show_icon("considered")
		elif cellInteractionType == CellInteractionType.CIT_CONSIDERING:
			search_icon.show_icon("considering")
		elif cellInteractionType == CellInteractionType.CIT_CONSIDERING_CURRENT:
			search_icon.show_icon("current_consider")
		elif cellInteractionType == CellInteractionType.CIT_FREE:
			search_icon.destroy_icon()

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		emit_signal("cell_clicked", self)
		


func _on_area_2d_mouse_entered():
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		emit_signal("cell_clicked", self)
	else:
		animation_player.play("BorderAnimation")
	


func _on_area_2d_mouse_exited():
	animation_player.play("BorderAnimation_existed")
