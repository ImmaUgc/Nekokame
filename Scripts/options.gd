extends Node2D

@onready var options = [
	$portuguese,
	$english,
	$windowed,
	$fullscreen,
	$Save
];

@onready var can_translate = [
	$Language,
	$portuguese,
	$english,
	$Screen,
	$windowed,
	$fullscreen,
	$Save
];

var last_colors = {};
@onready var config = Global.get_config();
@onready var new_config = config;
var current = 0;
var last = null;

var last_key = null;

@onready var select_sound = $'Select Sound';
@onready var selected_sound = $'Selected Sound';
var blocked = true;

func _ready():
	modulate = Color8(255, 255, 255, 0);
	options[current].set('theme_override_colors/default_color', Color.WEB_GREEN);
	for option in options:
		last_colors[option.name] = Color.BLACK;
	load_configs();
	await Global.transition(self, $Music, 'IN', 1);
	blocked = false;

func load_configs():
	var text_options = Global.get_text_file('Options');
	for index in len(can_translate):
		can_translate[index].text = '[center][wave freq=1]' + text_options[index];
	if(config['language'] == 'pt-br'):
		last_colors['portuguese'] = Color.GREEN;
		$portuguese.set('theme_override_colors/default_color', Color.GREEN);
	elif(config['language'] == 'en-us'):
		last_colors['english'] = Color.GREEN;
		$english.set('theme_override_colors/default_color', Color.GREEN);
	
	if(config['mode'] == 'WINDOW_MODE_FULLSCREEN'):
		last_colors['fullscreen'] = Color.GREEN;
		$fullscreen.set('theme_override_colors/default_color', Color.GREEN);
	elif(config['mode'] == 'WINDOW_MODE_WINDOWED'):
		last_colors['windowed'] = Color.GREEN;
		$windowed.set('theme_override_colors/default_color', Color.GREEN);

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
			if(options[current].name == 'portuguese'):
				last_colors['portuguese'] = Color.GREEN;
				last_colors['english'] = Color.BLACK;
				$english.set('theme_override_colors/default_color', Color.BLACK);
				options[current].set('theme_override_colors/default_color', Color.GREEN);
				new_config['language'] = 'pt-br';
			elif(options[current].name == 'english'):
				last_colors['portuguese'] = Color.BLACK;
				last_colors['english'] = Color.GREEN;
				$portuguese.set('theme_override_colors/default_color', Color.BLACK);
				options[current].set('theme_override_colors/default_color', Color.GREEN);
				new_config['language'] = 'en-us';
			elif(options[current].name == 'windowed'):
				last_colors['fullscreen'] = Color.BLACK;
				last_colors['windowed'] = Color.GREEN;
				$fullscreen.set('theme_override_colors/default_color', Color.BLACK);
				options[current].set('theme_override_colors/default_color', Color.GREEN);
				new_config['mode'] = 'WINDOW_MODE_WINDOWED';
			elif(options[current].name == 'fullscreen'):
				last_colors['fullscreen'] = Color.GREEN;
				last_colors['windowed'] = Color.BLACK;
				$windowed.set('theme_override_colors/default_color', Color.BLACK);
				options[current].set('theme_override_colors/default_color', Color.GREEN);
				new_config['mode'] = 'WINDOW_MODE_FULLSCREEN';
			elif(options[current].name == 'Save'):
				Global.set_config(new_config['language'], new_config['mode']);
				Global.scene_transition('res://Scenes/main_menu.tscn', self, $Music, 'OUT', 1);
		elif(key == 'Escape'):
			Global.scene_transition('res://Scenes/main_menu.tscn', self, $Music, 'OUT', 1);
		if(current > options.size() - 1):
			current = options.size() - 1;
		if(current < 0):
			current = 0;
		last.set('theme_override_colors/default_color', last_colors[last.name]);
		options[current].set('theme_override_colors/default_color', Color.WEB_GREEN);
	if(event.is_released() and key == last_key and not blocked):
		last_key = null;
