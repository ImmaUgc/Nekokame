extends ColorRect

@onready var Elements = $elements;
@onready var Name = $elements/DialogName;
@onready var Text = $elements/DialogText;
@onready var CharacterFace = $elements/DialogFace;
@onready var EnterButton = $elements/Enter;

@onready var Talking = $Talking;

signal next_text;
signal dialog_ended;
var can_go = false;

func _ready():
	Elements.modulate = Color8(255, 255, 255, 0);
	var blur = -1;
	while(blur < 2):
		blur += 0.5
		setBlur(blur);
		await get_tree().create_timer(0.01).timeout;
	startDialog();

func _process(_delta):
	EnterButton.play('default');
	EnterButton.visible = can_go;

func _input(event):
	var key = event.as_text();
	if(key == 'Enter' and can_go):
		next_text.emit();

func setBlur(blur):
	var shader_material = (material as ShaderMaterial);
	shader_material.set_shader_parameter('strength', blur);

func startDialog():
	var CurrentDialog = Global.current_dialog;
	Text.visible_characters = 0;
	Name.text = '[center]' + CurrentDialog[0].character.to_upper();
	CharacterFace.animation = CurrentDialog[0].character;
	Global.transition(Elements, null, 'IN', 0.5);
	for item in CurrentDialog:
		Talking.stream = load('res://Sounds/Talk/' + CurrentDialog[0].character + '.mp3');
		can_go = false;
		Text.text = item['text'];
		CharacterFace.play();
		Talking.play();
		while(Text.visible_characters < Text.get_total_character_count()):
			Text.visible_characters += 1;
			await get_tree().create_timer(0.05).timeout;
		CharacterFace.stop();
		Talking.stop();
		can_go = true;
		await next_text;
		Text.visible_characters = 0;
	destroy();

func destroy():
	Global.transition(Elements, null, 'OUT', 0.5);
	var blur = 2;
	while(blur > -1):
		blur -= 0.5
		setBlur(blur);
		await get_tree().create_timer(0.01).timeout;
	dialog_ended.emit();
	queue_free();
