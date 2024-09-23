extends CharacterBody2D
class_name TrickOrTreater


#https://www.reddit.com/r/godot/comments/1chhk8d/comment/l23ltjg/

signal spooked


const SPRITE_FRAMES_GHOST = preload("res://textures/sprite_frames/sprite_frames_ghost.tres")
const SPRITE_FRAMES_WITCH = preload("res://textures/sprite_frames/sprite_frames_witch.tres")
const DROPPED_MONEY = preload("res://scenes/dropped_money.tscn")
const DROPPED_CANDY = preload("res://scenes/dropped_candy.tscn")

const BRAVERY_GHOST = 20.0
const BRAVERY_WITCH = 30.0
const CROWD_SPOOK_GHOST = 1.0
const CROWD_SPOOK_WITCH = 3.0
const MONEY_DROP_GHOST = 1
const MONEY_DROP_WITCH = 3
const CANDY_DROP_GHOST = 2
const CANDY_DROP_WITCH = 3


@export var speed: float = 10.0
@export_enum("Ghost", "Witch") var type: int = 0


var bravery: float:
	set(value):
		if ready_to_navigate:
			if bravery != value:
				_bravery_changed(value)
			bravery = value
var bravery_max: float
var ready_to_navigate := false
var porch: Area2D
var exit: Area2D
var target_pos: Vector2
var exit_pos: Vector2
var got_candy := false
var getting_candy := false
var path := PackedVector2Array([])
var running_away := false
var nearby_tots: Array[TrickOrTreater] = []
var current_animation: String:
	set(value):
		if current_animation != value:
			_change_animation(value)
		current_animation = value
var stop_moving := false
var spook_resistance: float = 1.0


@onready var timer_trick_or_treat = $TimerTrickOrTreat
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var bravery_meter = $AnimatedSprite2D/BraveryMeter
@onready var navigation_agent_2d = $NavigationAgent2D
@onready var animated_sprite_bravery = $AnimatedSpriteBravery
@onready var audio_stream_player_spooked = $AudioStreamPlayerSpooked


func _ready():
	NavigationServer2D.map_changed.connect(_on_map_changed)
	porch = get_tree().get_first_node_in_group("porch")
	exit = get_tree().get_first_node_in_group("exit")
	target_pos = porch.global_position
	exit_pos = exit.global_position
	#bravery_meter.max_value = bravery
	#bravery_meter.value = bravery
	if type == 0:
		animated_sprite_2d.sprite_frames = SPRITE_FRAMES_GHOST
		bravery = BRAVERY_GHOST
		bravery_max = BRAVERY_GHOST
	elif type == 1:
		animated_sprite_2d.sprite_frames = SPRITE_FRAMES_WITCH
		bravery = BRAVERY_WITCH
		bravery_max = BRAVERY_WITCH
	
	animated_sprite_bravery.play("not_spooked_bar")
	animated_sprite_bravery.visible = false


func _physics_process(delta):
	if not ready_to_navigate:
		pass
	else:
		var next_pos = navigation_agent_2d.get_next_path_position()
		var dir_to_next_pos = global_position.direction_to(next_pos)
		if stop_moving:
			velocity = Vector2.ZERO
		else:
			velocity = dir_to_next_pos * speed
		if velocity.is_zero_approx():
			animated_sprite_2d.flip_h = false
		elif abs(velocity.x) > abs(velocity.y):
			if running_away:
				current_animation = "lrun"
			else:
				current_animation = "lwalk"
			
			if velocity.x > 0.0:
				animated_sprite_2d.flip_h = true
			else:
				animated_sprite_2d.flip_h = false
		else:
			animated_sprite_2d.flip_h = false
			if velocity.y > 0.0:
				if running_away:
					current_animation = "frun"
				else:
					current_animation = "fwalk"
			else:
				if running_away:
					current_animation = "brun"
				else:
					current_animation = "bwalk"
		move_and_slide()


func _calculate_resistance():
	spook_resistance = 1.0 - float(clampi(nearby_tots.size(), 0, 5)) / 6.0
	print(spook_resistance)


func _change_animation(value: String):
	animated_sprite_2d.play(value)


func set_movement_target(movement_target: Vector2):
	navigation_agent_2d.target_position = movement_target


func _bravery_changed(value: float):
	#if bravery_meter:
		#bravery_meter.set_value_no_signal(value)
	if not running_away:
		if value <= 0.0:
			_run_away()
		else:
			var bravery_pct = value / bravery_max
			var bravery_frame = floori((1.0 - bravery_pct) * 9.5)
			animated_sprite_bravery.frame = bravery_frame
			if value < bravery_max:
				animated_sprite_bravery.visible = true


func _run_away():
	emit_signal("spooked")
	_drop_money()
	audio_stream_player_spooked.pitch_scale = randfn(1.0, 0.1)
	audio_stream_player_spooked.play()
	if got_candy:
		_drop_candy()
	animated_sprite_bravery.play("spooked")
	animated_sprite_bravery.offset.y = -30.0
	running_away = true
	set_movement_target(exit_pos)
	speed *= 3.0
	var crowd_spook: float
	if type == 0:
		crowd_spook = CROWD_SPOOK_GHOST
	elif type == 1:
		crowd_spook = CROWD_SPOOK_WITCH
	for tot in nearby_tots:
		if not tot.stop_moving:
			tot.bravery -= crowd_spook


func _drop_candy():
	if type == 0:
		for i in CANDY_DROP_GHOST:
			var new_candy = DROPPED_CANDY.instantiate()
			get_parent().add_child(new_candy)
			new_candy.global_position = global_position + Vector2(randfn(0.0, 2.0), randfn(0.0, 2.0))
	elif type == 1:
		for i in CANDY_DROP_WITCH:
			var new_candy = DROPPED_CANDY.instantiate()
			get_parent().add_child(new_candy)
			new_candy.global_position = global_position + Vector2(randfn(0.0, 2.0), randfn(0.0, 2.0))


func _drop_money():
	if type == 0:
		for i in MONEY_DROP_GHOST:
			var new_money = DROPPED_MONEY.instantiate()
			get_parent().add_child(new_money)
			new_money.global_position = global_position + Vector2(randfn(0.0, 2.0), randfn(0.0, 2.0))
	elif type == 1:
		for i in MONEY_DROP_WITCH:
			var new_money = DROPPED_MONEY.instantiate()
			get_parent().add_child(new_money)
			new_money.global_position = global_position + Vector2(randfn(0.0, 2.0), randfn(0.0, 2.0))


func _on_timer_start_nav_timeout():
	set_movement_target(target_pos)
	ready_to_navigate = true
	if type == 0:
		bravery = BRAVERY_GHOST
		bravery_max = BRAVERY_GHOST
	elif type == 1:
		bravery = BRAVERY_WITCH
		bravery_max = BRAVERY_WITCH


func leave():
	print("leaving")
	queue_free()


func begin_exit():
	set_movement_target(exit_pos)
	stop_moving = false
	animated_sprite_2d.play()
	print("bye!")
	got_candy = true


func trick_or_treat():
	print("trick or treat!")
	timer_trick_or_treat.start()
	animated_sprite_2d.pause()
	bravery = min(bravery + 5.0, bravery_max)


func _on_timer_trick_or_treat_timeout():
	begin_exit()


func _on_map_changed():
	pass


func _on_area_crowd_effect_body_entered(body):
	if body.is_in_group("tot") and body != self:
		if not body.running_away:
			nearby_tots.append(body)
			spook_resistance = 1.0 - (float(clampi(nearby_tots.size(), 0, 5)) / 6.0)
		else:
			if not stop_moving:
				if body.type == 0:
					bravery -= CROWD_SPOOK_GHOST * 0.5
				elif body.type == 1:
					bravery -= CROWD_SPOOK_WITCH * 0.5
			


func _on_area_crowd_effect_body_exited(body):
	if body.is_in_group("tot") and body != self:
		nearby_tots.erase(body)
		spook_resistance = 1.0 - (float(clampi(nearby_tots.size(), 0, 5)) / 6.0)


func _on_navigation_agent_2d_waypoint_reached(details):
	pass # Replace with function body.


func _on_navigation_agent_2d_target_reached():
	print("done")
	stop_moving = true
