tool
extends HBoxContainer

var icons = {
	"up": preload("res://addons/todot/assets/ArrowUp.svg"),
	"down": preload("res://addons/todot/assets/ArrowDown.svg"),
	"very_up": preload("res://addons/todot/assets/MoveUp.svg"),
	"very_down": preload("res://addons/todot/assets/MoveDown.svg"),
	"remove": preload("res://addons/todot/assets/Remove.svg")
}

signal move_task(task, distance)
signal delete_task(task)

var task:Task

func _enter_tree():
	$Options.get_popup().clear()
	$Options.get_popup().add_icon_item(icons["up"], "Move Up")
	$Options.get_popup().add_icon_item(icons["down"], "Move Down")
	$Options.get_popup().add_icon_item(icons["very_up"], "Move to Top")
	$Options.get_popup().add_icon_item(icons["very_down"], "Move to Bottom")
	$Options.get_popup().add_icon_item(icons["remove"], "Delete")
	$Options.get_popup().connect("id_pressed", self, "option_pressed")
	
func option_pressed(id):
	match id:
		0:
			emit_signal("move_task", task, -1)
		1:
			emit_signal("move_task", task, 1)
		2:
			emit_signal("move_task", task, -100)
		3:
			emit_signal("move_task", task, 100)
		4:
			emit_signal("delete_task", task)
		
func init(task):
	self.task = task
	$TaskText.text = task.text
	$Completed.pressed = task.completed

func _on_TaskText_text_changed(new_text):
	task.text = new_text

func _on_Completed_toggled(button_pressed):
	task.completed = button_pressed
	$TaskText.editable = !task.completed
