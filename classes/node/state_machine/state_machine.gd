# Copyright 2026 CE-Studio: LGPL-3.0-only
# contrib: LasagnaBones
class_name StateMachine
extends Node

@onready var initial_state:Node = get_child(0)
@onready var actor:Node = owner

var current_state:State
var _states:Dictionary[StringName, State]


func _ready() -> void:
	current_state = initial_state
	for child in get_children():
		if child is State:
			_states[child.Name] = child
			child.actor = actor
			child.transition_requested.connect(_on_transtion_requested)
	current_state.enter()


func _process(delta:float) -> void:
	current_state.update(delta)
	current_state.time_in_state += delta


func _physics_process(delta:float) -> void:
	current_state.physics_update(delta)


## internal for transitions
func _on_transtion_requested(goal_state:StringName) -> void:
	current_state.exit()
	current_state = _states.get(goal_state)
	current_state.enter()
	current_state.time_in_state = 0.0


func transition_to(goal_state:StringName) -> void:
	_on_transtion_requested(goal_state)
