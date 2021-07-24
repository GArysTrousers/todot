class_name List
extends Node

var list_name:String
var tasks:Array = []

func init(list_name):
	self.list_name = list_name

func serialize():
	var data = {
		"list_name": list_name,
		"tasks": []
	}
	for t in tasks:
		data["tasks"].append(t.serialize())
	return data

func deserialize(data):
	list_name = data["list_name"]
	tasks = []
	for t in data["tasks"]:
		var task = Task.new()
		task.deserialize(t)
		tasks.append(task)

func to_string():
	var output = "list_name: %s" % list_name
	for task in tasks:
		output += task.to_string()
