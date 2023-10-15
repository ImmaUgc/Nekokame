extends Node2D

func _ready():
	modulate = Color8(255, 255, 255, 0);
	Global.transition(self, $Music, 'IN', 1);
