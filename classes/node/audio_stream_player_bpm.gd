# Copyright 2026 CE-Studio: LGPL-3.0-only
class_name AudioStreamPlayerBPM
extends AudioStreamPlayer


## Emitted every beat.
signal beat
## Emitted on even beats.
signal even_beat
## Emitted on odd beats.
signal odd_beat
## Fallback of if AudioStream does not have a BPM property.
@export var bpm:float = 120
## Keeps track of the number of beats so far.
var beat_track:int = 0


func _ready() -> void:
	if stream is AudioStreamMP3:
		bpm = stream.bpm
	elif stream is AudioStreamOggVorbis:
		bpm = stream.bpm
	elif stream is AudioStreamPlaylist:
		bpm = stream.get_bpm()


func _process(_delta: float) -> void:
	if not playing:
		return
	var playtime := get_playback_position() + AudioServer.get_time_since_last_mix()
	playtime = playtime / 60.0
	var beats := floori(playtime * bpm)
	if beats != beat_track:
		beat_track = beats
		beat.emit()
		if beats % 2:
			odd_beat.emit()
		else:
			even_beat.emit()
