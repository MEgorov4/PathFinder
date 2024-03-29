class_name PathDrawer
extends Node2D

#Signals
signal drawing_path_complited()
signal draw_segment_complited()

# Settings
@export var path_width : float = 2
@export var path_add_point_timeout : float = 0
@export var path_gradient_start_color : Gradient
@export var max_audio_pitch : float = 2
@export var b_play_draw_sound : bool = true

# Components
var path_line : Line2D
var path_audio_player : AudioStreamPlayer2D
var path_particles : CPUParticles2D
func _ready():
	path_line = get_node("PathLine")
	path_audio_player = get_node("Audio")
	path_particles = get_node("SparkExplosue")
	path_line.width = path_width

func _process(delta):
	pass

# Метод для плавного построения пути 
func draw_path(Cells, draw_color : Color, offset = Vector2(0, 0),):
	_reset_all_components()
	
	path_line.default_color = draw_color
	
	path_particles.emitting = true
	
	if path_line != null && Cells.size() > 1:
		# Устанавливаем изначальную частоту звука 
		path_audio_player.pitch_scale = max_audio_pitch / Cells.size()
		for cell in Cells:
			# Добавляем новый сегмент
			path_line.add_point(cell.position + offset)
			
			path_particles.position = cell.position + offset
			
			
			if b_play_draw_sound:
				# Воспроизводим звук построения сегмента и сдвигаем частоту
				path_audio_player.position = cell.position + offset
				path_audio_player.play()
			path_audio_player.pitch_scale += max_audio_pitch / Cells.size()
			
			
			emit_signal("draw_segment_complited")
			
			await get_tree().create_timer(path_add_point_timeout).timeout
			
	path_particles.emitting = false
	emit_signal("drawing_path_complited")
func clear_path():
	_reset_all_components()
	
func _reset_all_components():
	path_audio_player.pitch_scale = max_audio_pitch
	path_line.clear_points()
	path_particles.emitting = false
	
