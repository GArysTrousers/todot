tool
extends VBoxContainer

var TaskItem = preload("res://addons/todot/TaskItem.tscn")

func show_list(list:List, show_hidden = false):
	clear()
	for task in list.tasks:
		if show_hidden || !task.hidden:
			add_task(task)

func clear():
	for task in get_children():
		task.queue_free()

func add_task(task:Task):
	var new_task = TaskItem.instance()
	new_task.init(task)
	new_task.connect("move_task", get_parent(), "move_task")
	new_task.connect("delete_task", get_parent(), "delete_task")
	add_child(new_task)
	

