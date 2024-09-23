extends Node2D


signal current_item(item: ShopItem)


const X_OFFSET = 36.0


var items: Array[ShopItem]:
	set(value):
		items = value
		_build_shop()
var selected_idx: int = 0:
	set(value):
		selected_idx = wrapi(value, 0, items.size())
		if items:
			emit_signal("current_item", items[selected_idx])
var intervals: Array[float] = []
var open := false:
	set(value):
		if open != value:
			_open_changed(value)
		open = value


@onready var slider = $Slider
@onready var cursor = $Cursor


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if open:
		if Input.is_action_just_pressed("left"):
			selected_idx -= 1
		if Input.is_action_just_pressed("right"):
			selected_idx += 1
		if items:
			slider.global_position.x = intervals[items.size() - 1 - selected_idx] - X_OFFSET


func _open_changed(value: bool):
	if value:
		emit_signal("current_item", items[selected_idx])


func _build_shop():
	for kid in slider.get_children():
		kid.queue_free()
	
	var x = 0.0
	intervals.clear()
	
	for item in items:
		var newsprite = Sprite2D.new()
		slider.add_child(newsprite)
		newsprite.texture = item.icon
		newsprite.global_position.x = x
		intervals.append(x)
		x += 24.0
	
	slider.global_position.x = intervals[-1] - X_OFFSET
	cursor.global_position.x = slider.global_position.x
	emit_signal("current_item", items[selected_idx])
