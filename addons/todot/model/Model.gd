class_name Model
extends Node

var cur_list = -1
var show_hidden = false
var lists:Array = []

func clear_completed_tasks_in_list(list_index):
	for task in lists[list_index].tasks:
		if task.completed:
			task.hidden = true

func move_list(list, distance):
	var index = lists.find(list)
	lists.remove(index)
	lists.insert(
		clamp(index + distance, 0, lists.size()), list)

func rename_list(list, new_name):
	var index = lists.find(list)
	lists[index].list_name = new_name
		
func delete_list(list):
	var index = lists.find(list)
	lists.remove(index)

func serialize():
	var data = {
		"cur_list": cur_list,
		"show_hidden": show_hidden,
		"lists": []
	}
	for l in lists:
		data["lists"].append(l.serialize())
	return data

func deserialize(data):
	cur_list = data["cur_list"]
	show_hidden = data["show_hidden"]
	lists = []
	for l in data["lists"]:
		var list = List.new()
		list.deserialize(l)
		lists.append(list)

func to_string():
	var output = "cur_list: %s\nshow_hidden: %s\n" % [cur_list, show_hidden]
	for list in lists:
		output = output + list.to_string()
	return output
