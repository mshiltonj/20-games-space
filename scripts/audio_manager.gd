extends Node

var registered_audio_streams : Dictionary[String, AudioStreamPlayer2D] = {}

func register(key_name : String, audio : AudioStream) -> void:
	var player : AudioStreamPlayer2D  = AudioStreamPlayer2D.new()
	player.stream = audio
	registered_audio_streams[key_name] = player
	self.add_child(player)
	
	
func unregister(key_name : String) -> void:
	pass
	
func play(key_name : String) -> void:
	registered_audio_streams[key_name].play()
	
func player_for(key_name : String) -> AudioStreamPlayer2D:
	return registered_audio_streams[key_name]
