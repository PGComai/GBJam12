extends Node2D
class_name Decoration


@export var icon: Texture2D
@export var _name: String
@export var range: int
@export var damage: float
@export var initial_damage: float
@export var damage_interval: float


var damage_timer: float
var tots_in_range: Array[TrickOrTreater] = []
var spook_dilution: float = 1.0
var group_damage_bonus: float = 1.0
var group_range_bonus: float = 1.0:
	set(value):
		if group_range_bonus != value:
			_group_range_bonus_changed(value)
		group_range_bonus = value
var cshape: CollisionShape2D


@onready var sprite_2d = $Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	damage_timer = damage_interval
	sprite_2d.texture = icon
	var new_area = Area2D.new()
	add_child(new_area)
	new_area.body_entered.connect(_on_area_body_entered)
	new_area.body_exited.connect(_on_area_body_exited)
	var new_cshape = CollisionShape2D.new()
	new_area.add_child(new_cshape)
	new_cshape.shape = CircleShape2D.new()
	new_cshape.shape.radius = float(range)
	cshape = new_cshape
	if _name == "Jack-O-Lantern":
		sprite_2d.offset.y = -2.0
	if _name == "Tombstone":
		sprite_2d.offset.y = -4.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	damage_timer -= delta
	if damage_timer <= 0.0:
		damage_timer += damage_interval
		_spook_tots()


func _group_range_bonus_changed(value: float):
	cshape.shape.radius = range * value


func _spook_tots():
	for tot in tots_in_range:
		if not tot.stop_moving:
			tot.bravery -= damage * tot.spook_resistance * spook_dilution * group_damage_bonus


func _on_area_body_entered(body):
	if body.is_in_group("tot"):
		if not body.running_away:
			tots_in_range.append(body)
			spook_dilution = 1.0 / max(float(tots_in_range.size()) * 0.1, 1.0)
		if not body.stop_moving:
			body.bravery -= initial_damage * body.spook_resistance * spook_dilution * group_damage_bonus


func _on_area_body_exited(body):
	if body.is_in_group("tot"):
		if tots_in_range.has(body):
			tots_in_range.erase(body)
			spook_dilution = 1.0 / max(float(tots_in_range.size()) * 0.1, 1.0)
