# Copyright 2026 CE-Studio: LGPL-3.0-only
# contrib: LasagnaBones
class_name TransitionRule
extends RefCounted


var condition:Callable
var target_state:StringName
var conditional_exits:Array[Callable]


func _init(target_state:StringName, condition:Callable, ...conds:Array) -> void:
	self.conditional_exits.assign(conds)
	self.target_state = target_state
	self.condition = condition


func run_exits() -> void:
	for exit in conditional_exits:
		exit.call()
