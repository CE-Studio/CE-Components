class_name MusicSyncedAnimationPlayer
extends AnimationPlayer


@export var beat_mode:MusicManager.BeatMode
@export var beat_animation:StringName
@export var alternate_beat_animation:StringName


func _ready() -> void:
	if has_animation(beat_animation):
		assert(is_instance_valid(MusicManager.instance), "No MusicManager instance!")
		match beat_mode:
			MusicManager.BeatMode.EVERY:
				MusicManager.instance.beat.connect(_trigger_a)
			MusicManager.BeatMode.EVEN:
				MusicManager.instance.even_beat.connect(_trigger_a)
			MusicManager.BeatMode.ODD:
				MusicManager.instance.odd_beat.connect(_trigger_a)
			MusicManager.BeatMode.ALTERNATE:
				MusicManager.instance.even_beat.connect(_trigger_a)
				MusicManager.instance.odd_beat.connect(_trigger_b)
	else:
		assert(false, "Invalid Animation!")


func _trigger_a() -> void:
	stop()
	play(beat_animation)


func _trigger_b() -> void:
	stop()
	play(alternate_beat_animation)
