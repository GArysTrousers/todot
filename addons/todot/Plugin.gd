tool
extends EditorPlugin

var dock

func _enter_tree():
	dock = preload("res://addons/todot/Dock.tscn").instance()
	add_control_to_dock(DOCK_SLOT_RIGHT_BL, dock)

func _exit_tree():
	remove_control_from_docks(dock)
	dock.free()

func save_external_data():
	dock.get_node("Project").save_project()
