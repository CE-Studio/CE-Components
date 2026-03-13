extends RefCounted
class_name Statics
## A class providing static functions or variables useful to all scripts.


## A static version of [method Node.get_node][br]
## Needs an [b]absolute[/b] path.
static func get_node(path:NodePath) -> Node:
	#This feels cheaty but it works ig
	return Engine.get_main_loop().current_scene.get_node(path)


## Takes an aprbitrary variant and tries to convert it to a number. Can return float, int, fallback or null.
static func to_number(inp:Variant, fallback:Variant = null) -> Variant:
	if inp is float:
		return inp
	if inp is int:
		return inp
	if inp is String:
		if inp.is_valid_float():
			if inp.is_valid_int():
				return inp.to_int()
			return inp.to_float()
		elif inp.is_valid_hex_number(true):
			return inp.hex_to_int()
		else:
			return fallback
	return fallback


## Creates a simple, time-based identifier. Rapid calls may return the same ID so be careful.
static func generate_uid() -> int:
	return hash(Time.get_unix_time_from_system())


## A wrapper of [method @GDScript.range] to be [b]inclusive[/b] of the second parameter.
static func inclusive_range(start:int, stop:int) -> Array:
	var dir:int
	if start >= stop:
		dir = -1
	else:
		dir = 1
	return range(start, stop + dir, dir)
