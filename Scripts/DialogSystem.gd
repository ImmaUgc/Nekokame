extends Node

func get_dialogs():
	return JSON.parse_string(FileAccess.open('res://Texts/Dialogs.json', FileAccess.READ).get_as_text());

func get_dialog(id):
	var dialogs = get_dialogs();
	var target = dialogs[id];
	var language = Global.get_config()['language'];
	return target[language];

func createDialog(dialogArray, current_scene_node: Node2D):
	Global.current_dialog = dialogArray;
	var dialogscene = preload('res://Scenes/Dialog.tscn').instantiate();
	dialogscene.size = DisplayServer.window_get_size();
	current_scene_node.add_child(dialogscene);
	return dialogscene.dialog_ended;
