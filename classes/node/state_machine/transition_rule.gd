# Copyright 2026 CE-Studio: LGPL-3.0-only
# contrib: LasagnaBones
class_name TransitionRule
extends RefCounted


var condition:Callable
var target_state:StringName


func _init(target_state:StringName, condition:Callable) -> void:
	self.target_state = target_state
	self.condition = condition
