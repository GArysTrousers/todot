class_name Task
extends Node

var text:String = ""
var completed:bool = false
var hidden:bool = false

func serialize():
	var data = {
		"text": text,
		"completed": completed,
		"hidden": hidden
	}
	return data

func deserialize(data):
	text = data["text"]
	completed = data["completed"]
	hidden = data["hidden"]

func to_string():
	return "text: %s\ncompleted: %s\nhidden: %s\n" % [text, completed, hidden]
