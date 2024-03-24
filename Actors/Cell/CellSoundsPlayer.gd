class_name CellAudioStreamPlayer
extends AudioStreamPlayer

var sounds = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	var delete_wall_sound_stream = load("res://Resources/Sounds/DeleteWall.wav")
	var place_wall_sound_stream = load("res://Resources/Sounds/PlaceWall.wav")
	sounds["delete_wall"] = delete_wall_sound_stream
	sounds["place_wall"] = place_wall_sound_stream
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func play_sound_by_name(sound_name):
	stream = sounds[sound_name]
	playing = true 
