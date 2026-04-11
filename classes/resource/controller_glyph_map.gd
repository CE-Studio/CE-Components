class_name ControllerGlyphMapping
extends Resource


enum {
	POSITIVE,
	NEGATIVE,
	COMBINED,
	DUAL,
}


@export var fallback:Texture2D
@export var fallback_button:Texture2D
@export var fallback_positive_axis:Texture2D
@export var fallback_negative_axis:Texture2D
@export var fallback_combined_axis:Texture2D
@export var fallback_dual_axis:Texture2D
@export var button_glyphs:Array[Texture2D]
@export var positive_axis_glyphs:Array[Texture2D]
@export var negative_axis_glyphs:Array[Texture2D]
@export var combined_axis_glyphs:Array[Texture2D]
@export var dual_axis_glyphs:Array[Texture2D]


func _get_g(id:int, array:Array[Texture2D], fb:Texture2D) -> Texture2D:
	if id < array.size():
		if is_instance_valid(array[id]):
			return array[id]
	return fb


func get_button_glyph(id:int) -> Texture2D:
	return _get_g(id, button_glyphs, fallback_button)


func get_positive_axis_glyph(id:int) -> Texture2D:
	return _get_g(id, positive_axis_glyphs, fallback_positive_axis)


func get_negative_axis_glyph(id:int) -> Texture2D:
	return _get_g(id, negative_axis_glyphs, fallback_negative_axis)


func get_combined_axis_glyph(id:int) -> Texture2D:
	return _get_g(id, combined_axis_glyphs, fallback_combined_axis)


func get_dual_axis_glyph(id:int) -> Texture2D:
	return _get_g(id, dual_axis_glyphs, fallback_dual_axis)


func get_glyph_from_event(event:InputEvent, mode := COMBINED) -> Texture2D:
	if event is InputEventJoypadButton:
		return get_button_glyph(event.button_index)
	if event is InputEventJoypadMotion:
		match mode:
			POSITIVE:
				return get_positive_axis_glyph(event.axis)
			NEGATIVE:
				return get_negative_axis_glyph(event.axis)
			COMBINED:
				return get_combined_axis_glyph(event.axis)
			DUAL:
				return get_dual_axis_glyph(event.axis)
	return fallback
