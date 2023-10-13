extends Node2D

@onready var selection = $Select;
@onready var options = [
	$Start,
	$Credits
];
@onready var current = 0;
@onready var select_sound = $'Select Sound';
@onready var selected_sound = $'Selected Sound';
var blocked = true;
var last_key;

func _ready():
	$Sombrinha/Floating.play('floating');
	await Global.transition(self, $Music, 'IN', 1);
	await Global.transition(selection, null, 'IN', 0.5);
	blocked = false;

func _input(event):
	var key = event.as_text();
	if(event.is_pressed() and key != last_key and not blocked):
		last_key = key;
		if(key == 'Down'):
			current += 1;
			select_sound.play();
		elif(key == 'Up'):
			current -= 1;
			select_sound.play();
		elif(key == 'Enter'):
			selected_sound.play();
			selection.play('blink');
			blocked = true;
			var scene;
			if(current == 0):
				pass;
			elif(current == 1):
				scene = 'res://Scenes/credits.tscn';
			Global.scene_transition(scene, self, $Music, 'OUT', 2);
		if(current > options.size() - 1):
			current = 0;
		if(current < 0):
			current = options.size() - 1; 
		selection.position.y = options[current].position.y;
	if(event.is_released() and key == last_key and not blocked):
		last_key = null;
