extends Node

func createDialog(dialogArray, current_scene_node: Node2D):
	Global.current_dialog = dialogArray;
	var dialogscene = preload('res://Scenes/Dialog.tscn').instantiate();
	dialogscene.size = DisplayServer.window_get_size();
	current_scene_node.add_child(dialogscene);
	return dialogscene.dialog_ended;
