extends Node3D
class_name DebugAABB


## Renders an AABB in-world for debug purposes


static var instance:DebugAABB


var aabb:AABB:
	set(val):
		show()
		position = val.position
		scale = val.size
		aabb = val


func _ready() -> void:
	if not is_instance_valid(instance):
		instance = self
	var m3d:MeshInstance3D = load("uid://lq70ang68e5j").instantiate()
	add_child(m3d, false, INTERNAL_MODE_BACK)
	m3d.position += Vector3(0.5, 0.5, 0.5)
