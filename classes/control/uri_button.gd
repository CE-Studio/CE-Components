# Copyright 2026 CE-Studio: LGPL-3.0-only
class_name URIButton
extends Button


@export var uri:String = ""


func _pressed() -> void:
	OS.shell_open(uri)
