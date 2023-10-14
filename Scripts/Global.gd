extends Node

var current_dialog = [];
var save_file = 'user://nekokame.save';

func save_game():
	var file = FileAccess.open(save_file, FileAccess.WRITE);
	file.store_string('teste');

func check_save():
	return FileAccess.file_exists(save_file);

func scene_transition(scene_name, current_scene_node, music, transition, duration):
	var modulate_tween = get_tree().create_tween();
	var music_tween = get_tree().create_tween();
	var final_values = [];
	if(transition == 'IN'):
		final_values.append(255);
		final_values.append(0);
	elif(transition == 'OUT'):
		final_values.append(0);
		final_values.append(-80);
	modulate_tween.tween_property(current_scene_node, 'modulate', Color8(255, 255, 255, final_values[0]), duration);
	if(music):
		music_tween.tween_property(music, 'volume_db', final_values[1], duration);
		music_tween.play();
	modulate_tween.play();
	await modulate_tween.finished;
	get_tree().change_scene_to_file(scene_name);

func transition(current_scene_node, music, transition, duration):
	var modulate_tween = get_tree().create_tween();
	var music_tween = get_tree().create_tween();
	var final_values = [];
	if(transition == 'IN'):
		final_values.append(255);
		final_values.append(0);
	elif(transition == 'OUT'):
		final_values.append(0);
		final_values.append(-80);
	modulate_tween.tween_property(current_scene_node, 'modulate', Color8(255, 255, 255, final_values[0]), duration);
	if(music):
		music_tween.tween_property(music, 'volume_db', final_values[1], duration);
		music_tween.play();
	modulate_tween.play();
	return modulate_tween.finished;
