extends CharacterBody2D

@onready var Sprites = $Sprites;
var idle_state = 'idle front';

func animate(move_x, move_y):
	if(move_x != 0 and move_y == 0):
		idle_state = 'idle right';
		Sprites.scale.x = move_x;
		Sprites.play('walking right');
	if(move_y != 0):
		if(move_y < 0):
			idle_state = 'idle back';
			Sprites.play('walking back');
		else:
			idle_state = 'idle front';
			Sprites.play('walking front');
	if(move_y == 0 and move_x == 0):
		Sprites.play(idle_state);

func _physics_process(delta):
	var move_x = Input.get_axis('left', 'right');
	var move_y = Input.get_axis('up', 'down');
	animate(move_x, move_y);
	move_and_collide(Vector2(move_x, move_y));
