tool
extends WindowDialog

func reset():
	get_parent().get_node("Dialog").confirm_input(
		"Are you sure?", 
		"This will delete all data from the project manager", 
		"reset_project", 
		get_parent().get_node("Project")
	)

func print_model():
	print(get_parent().get_node("Project").model.serialize())

func open_github():
	OS.shell_open("https://github.com/GArysTrousers/todot")
