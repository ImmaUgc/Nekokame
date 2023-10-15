extends Node2D

func _ready():
	Dialog.createDialog(Dialog.get_dialog('dialog intro'), self);
