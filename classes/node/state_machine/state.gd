# Copyright 2026 CE-Studio: LGPL-3.0-only
# contrib: LasagnaBones
@abstract class_name State
extends Node


signal transition_requested(target_state:StringName)


var _transition_rules:Array[TransitionRule]
var actor:Node
var time_in_state := 0.0


@abstract func set_up_transitions() -> void
@abstract func enter() -> void
@abstract func exit() -> void
@abstract func update(delta:float) -> void
@abstract func physics_update(delta:float) -> void


func add_transition(target_state:StringName, condition:Callable) -> void:
	_transition_rules.append(TransitionRule.new(target_state, condition))


func check_transitions() -> void:
	for rule in _transition_rules:
		if (rule.condition.call() == true):
			rule.run_exits()
			request_transition(rule.target_state)


func request_transition(target_state:StringName):
	transition_requested.emit(target_state)


func state_ready() -> void:
	set_up_transitions()
