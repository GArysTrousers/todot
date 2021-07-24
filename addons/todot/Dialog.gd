tool
extends ConfirmationDialog

enum Mode { Confirm, Multi, Single }
var mode
var caller_node
var caller_function

func confirm_input(title:String, message:String, function:String, node:Node):
	setup(Mode.Confirm, title, function, node)
	add_label(message)
	popup_centered()

func single_input(title:String, var_name:String, function:String, node:Node):
	setup(Mode.Single, title, function, node)
	add_line_edit(var_name)
	popup_centered()
	$Inputs.get_child(0).grab_focus()

func multi_input(title:String, var_names:Array, function:String, node:Node):
	setup(Mode.Multi, title, function, node)
	for v in var_names:
		add_line_edit(v)
	popup_centered()
	
func setup(mode, title:String, function:String, node:Node):
	self.mode = mode
	window_title = title
	caller_node = node
	caller_function = function
	for c in $Inputs.get_children():
		c.queue_free()
		
func add_line_edit(var_name):
	var line_edit = LineEdit.new()
	line_edit.placeholder_text = var_name
	$Inputs.add_child(line_edit)

func add_label(text):
	var label = Label.new()
	label.text = text
	$Inputs.add_child(label)

func confirmed():
	match mode:
		Mode.Confirm:
			caller_node.call(caller_function)
		Mode.Single:
			var data
			for c in $Inputs.get_children():
				data = c.text
			caller_node.call(caller_function, data)
		Mode.Multi:
			var data
			for c in $Inputs.get_children():
				data[c.placeholder_text] = c.text
			caller_node.call(caller_function, data)
