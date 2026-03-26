class_name MarginContainerPercent
extends MarginContainer


@export_range(0, 100) var margin_left := 10.0
@export_range(0, 100) var margin_right := 10.0
@export_range(0, 100) var margin_top := 10.0
@export_range(0, 100) var margin_bottom := 10.0


func recalc() -> void:
	var rect := get_rect()
	if margin_left != 0:
		var l := rect.size.x * (margin_left / 100.0)
		add_theme_constant_override(&"margin_left", l)
	else:
		remove_theme_constant_override(&"margin_left")
	if margin_right != 0:
		var r := rect.size.x * (margin_right / 100.0)
		add_theme_constant_override(&"margin_right", r)
	else:
		remove_theme_constant_override(&"margin_right")
	if margin_top != 0:
		var t := rect.size.y * (margin_top / 100.0)
		add_theme_constant_override(&"margin_top", t)
	else:
		remove_theme_constant_override(&"margin_top")
	if margin_bottom != 0:
		var b := rect.size.y * (margin_bottom / 100.0)
		add_theme_constant_override(&"margin_bottom", b)
	else:
		remove_theme_constant_override(&"margin_bottom")


func _ready() -> void:
	recalc()
	item_rect_changed.connect(recalc)
