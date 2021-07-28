tool
extends WindowDialog

var ListItem = preload("res://addons/todot/ListItem.tscn")
var last_open_list

func show_lists():
	var model = get_parent().get_node("Project").model
	for child in $VBoxContainer/ScrollContainer/Lists.get_children():
		child.queue_free()
	for list in model.lists:
		var list_item = ListItem.instance()
		list_item.init(list)
		list_item.connect("move_list", self, "move_list")
		list_item.connect("rename_list", self, "rename_list")
		list_item.connect("delete_list", self, "delete_list")
		$VBoxContainer/ScrollContainer/Lists.add_child(list_item)

func move_list(list, distance):
	get_parent().get_node("Project").model.move_list(list, distance)
	show_lists()

func rename_list(list, new_name):
	get_parent().get_node("Project").model.rename_list(list, new_name)

func delete_list(list):
	get_parent().get_node("Project").model.delete_list(list)
	show_lists()

func on_open():
	var model = get_parent().get_node("Project").model
	if model.cur_list > -1:
		last_open_list = model.lists[model.cur_list]
	else:
		last_open_list = null
	show_lists()

func on_close():
	var project = get_parent().get_node("Project")
	project.update_lists()
	project.change_to_list_by_ref(last_open_list)
