# Copyright 2026 CE-Studio: LGPL-3.0-only
class_name MusicManager
extends Node


signal beat
signal odd_beat
signal even_beat


static var instance:MusicManager
static var players:Array[AudioStreamPlayerBPM]
static var levels:Array[float] = []
static var old_idx:int = 0
static var idx:int = 0:
	set(value):
		old_idx = idx
		idx = clampi(value, -1, players.size() - 1)


var _fader:float = 0.0
var _running := false


func _beat(i:int) -> void:
	if i == idx:
		beat.emit()


func _odd_beat(i:int) -> void:
	if i == idx:
		odd_beat.emit()


func _even_beat(i:int) -> void:
	if i == idx:
		even_beat.emit()


static func set_music(i:int) -> void:
	if not is_instance_valid(instance):
		return
	instance._running = true
	instance._fader = 1.0
	idx = i
	if idx != -1:
		if is_instance_valid(players[idx]):
			players[idx].volume_db = -80
			players[idx].play()


func _process(delta: float) -> void:
	if not _running:
		return
	if _fader <= 0:
		_fader = 0
		_running = false
		for i in players.size():
			var p := players[i]
			if i == idx:
				p.volume_db = levels[i]
			else:
				p.volume_db = -80
				p.stop()
	else:
		for i in players.size():
			var p := players[i]
			if i == idx:
				p.volume_db = maxf(remap(_fader, 0, 1, levels[i], -80), p.volume_db)
			else:
				p.volume_db = minf(remap(_fader, 0, 1, -80, levels[i]), p.volume_db)
		_fader -= (delta * 3.0)


func _ready() -> void:
	instance = self
	players = []
	levels = []
	for i in get_children():
		if i is AudioStreamPlayerBPM:
			players.append(i)
			levels.append(i.volume_db)
	for i in players.size():
		var p := players[i]
		p.bus = &"Music"
		p.volume_db = -80
		p.beat.connect(_beat.bind(i))
		p.odd_beat.connect(_odd_beat.bind(i))
		p.even_beat.connect(_even_beat.bind(i))
	await get_tree().process_frame
	await get_tree().process_frame
	if players.size() > 0:
		players[0].play.call_deferred()
		players[0].volume_db = 0
	idx = 0
