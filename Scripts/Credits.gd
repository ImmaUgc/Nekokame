extends Node2D

func _ready():
	Global.transition(self, $Music, 'IN', 1);
