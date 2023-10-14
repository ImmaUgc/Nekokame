extends Node2D

@onready var options = [
	$Continue,
	$'New Game',
	$Options,
	$Credits
];
var current = 0;
var last = null;
@onready var select_sound = $'Select Sound';
@onready var selected_sound = $'Selected Sound';

@onready var PawAnimation = $Nekinha/Hover;

var blocked = true;
var last_key;

func _ready():
	if(not Global.check_save()):
		$Continue.set('theme_override_colors/default_color', Color8(0, 0, 0, 100));
		options.remove_at(0);
	options[current].set('theme_override_colors/default_color', Color.WEB_GREEN);
	$Sombrinha/Floating.play('floating');
	await Global.transition(self, $Music, 'IN', 1);
	blocked = false;
	PawAnimation.play('in');

func _input(event):
	var key = event.as_text();
	if(event.is_pressed() and key != last_key and not blocked):
		last_key = key;
		last = options[current];
		if(key == 'Down'):
			current += 1;
			select_sound.play();
		elif(key == 'Up'):
			current -= 1;
			select_sound.play();
		elif(key == 'Enter'):
			selected_sound.play();
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
		last.set('theme_override_colors/default_color', Color.BLACK);
		options[current].set('theme_override_colors/default_color', Color.WEB_GREEN);
	if(event.is_released() and key == last_key and not blocked):
		last_key = null;
