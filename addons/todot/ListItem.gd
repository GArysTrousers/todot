tool
extends HBoxContainer

var icons = {
	"up": preload("res://addons/todot/assets/ArrowUp.svg"),
	"down": preload("res://addons/todot/assets/ArrowDown.svg"),
	"edit": preload("res://addons/todot/assets/Edit.svg"),
	"remove": preload("res://addons/todot/assets/Remove.svg")
}

signal move_list(list, distance)
signal rename_list(list, new_name)
signal delete_list(list)

var list:List

func _enter_tree():
	$Options.get_popup().clear()
	$Options.get_popup().add_icon_item(icons["remove"], "Delete")
	$Options.get_popup().connect("id_pressed", self, "option_pressed")
	
func option_pressed(id):
	match id:
		0:
			emit_signal("delete_list", list)
		
func init(list):
	self.list = list
	$ListName.text = list.list_name

func move_up():
	emit_signal("move_list", list, -1)
	
func move_down():
	emit_signal("move_list", list, 1)

func rename_list(new_name):
	emit_signal("rename_list", list, new_name)
	pass
