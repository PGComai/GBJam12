extends Node2D


const CURSOR_STEP = 16.0
const SCREEN_CENTER = Vector2(80.0, 72.0)
const MAX_TOT_INTERVAL = 10.0
const DECOR_Y_OFFSET = 6.0
const GROUP_2_INTERVAL = 7.0
const GROUP_3_INTERVAL = 13.0
const GROUP_4_INTERVAL = 19.0
const GROUP_5_INTERVAL = 31.0
const WITCH_INTERVAL = 10.0
const CALENDAR_LEAP = ["Nov 01", "Nov 02", "Nov 03", "Nov 04", "Nov 05", "Nov 06", "Nov 07", "Nov 08", "Nov 09", "Nov 10", "Nov 11", "Nov 12", "Nov 13", "Nov 14", "Nov 15", "Nov 16", "Nov 17", "Nov 18", "Nov 19", "Nov 20", "Nov 21", "Nov 22", "Nov 23", "Nov 24", "Nov 25", "Nov 26", "Nov 27", "Nov 28", "Nov 29", "Nov 30",
				"Dec 01", "Dec 02", "Dec 03", "Dec 04", "Dec 05", "Dec 06", "Dec 07", "Dec 08", "Dec 09", "Dec 10", "Dec 11", "Dec 12", "Dec 13", "Dec 14", "Dec 15", "Dec 16", "Dec 17", "Dec 18", "Dec 19", "Dec 20", "Dec 21", "Dec 22", "Dec 23", "Dec 24", "Dec 25", "Dec 26", "Dec 27", "Dec 28", "Dec 29", "Dec 30", "Dec 31",
				"Jan 01", "Jan 02", "Jan 03", "Jan 04", "Jan 05", "Jan 06", "Jan 07", "Jan 08", "Jan 09", "Jan 10", "Jan 11", "Jan 12", "Jan 13", "Jan 14", "Jan 15", "Jan 16", "Jan 17", "Jan 18", "Jan 19", "Jan 20", "Jan 21", "Jan 22", "Jan 23", "Jan 24", "Jan 25", "Jan 26", "Jan 27", "Jan 28", "Jan 29", "Jan 30", "Jan 31",
				"Feb 01", "Feb 02", "Feb 03", "Feb 04", "Feb 05", "Feb 06", "Feb 07", "Feb 08", "Feb 09", "Feb 10", "Feb 11", "Feb 12", "Feb 13", "Feb 14", "Feb 15", "Feb 16", "Feb 17", "Feb 18", "Feb 19", "Feb 20", "Feb 21", "Feb 22", "Feb 23", "Feb 24", "Feb 25", "Feb 26", "Feb 27", "Feb 28", "Feb 29",
				"Mar 01", "Mar 02", "Mar 03", "Mar 04", "Mar 05", "Mar 06", "Mar 07", "Mar 08", "Mar 09", "Mar 10", "Mar 11", "Mar 12", "Mar 13", "Mar 14", "Mar 15", "Mar 16", "Mar 17", "Mar 18", "Mar 19", "Mar 20", "Mar 21", "Mar 22", "Mar 23", "Mar 24", "Mar 25", "Mar 26", "Mar 27", "Mar 28", "Mar 29", "Mar 30", "Mar 31",
				"Apr 01", "Apr 02", "Apr 03", "Apr 04", "Apr 05", "Apr 06", "Apr 07", "Apr 08", "Apr 09", "Apr 10", "Apr 11", "Apr 12", "Apr 13", "Apr 14", "Apr 15", "Apr 16", "Apr 17", "Apr 18", "Apr 19", "Apr 20", "Apr 21", "Apr 22", "Apr 23", "Apr 24", "Apr 25", "Apr 26", "Apr 27", "Apr 28", "Apr 29", "Apr 30",
				"May 01", "May 02", "May 03", "May 04", "May 05", "May 06", "May 07", "May 08", "May 09", "May 10", "May 11", "May 12", "May 13", "May 14", "May 15", "May 16", "May 17", "May 18", "May 19", "May 20", "May 21", "May 22", "May 23", "May 24", "May 25", "May 26", "May 27", "May 28", "May 29", "May 30", "May 31",
				"Jun 01", "Jun 02", "Jun 03", "Jun 04", "Jun 05", "Jun 06", "Jun 07", "Jun 08", "Jun 09", "Jun 10", "Jun 11", "Jun 12", "Jun 13", "Jun 14", "Jun 15", "Jun 16", "Jun 17", "Jun 18", "Jun 19", "Jun 20", "Jun 21", "Jun 22", "Jun 23", "Jun 24", "Jun 25", "Jun 26", "Jun 27", "Jun 28", "Jun 29", "Jun 30",
				"Jul 01", "Jul 02", "Jul 03", "Jul 04", "Jul 05", "Jul 06", "Jul 07", "Jul 08", "Jul 09", "Jul 10", "Jul 11", "Jul 12", "Jul 13", "Jul 14", "Jul 15", "Jul 16", "Jul 17", "Jul 18", "Jul 19", "Jul 20", "Jul 21", "Jul 22", "Jul 23", "Jul 24", "Jul 25", "Jul 26", "Jul 27", "Jul 28", "Jul 29", "Jul 30", "Jul 31",
				"Aug 01", "Aug 02", "Aug 03", "Aug 04", "Aug 05", "Aug 06", "Aug 07", "Aug 08", "Aug 09", "Aug 10", "Aug 11", "Aug 12", "Aug 13", "Aug 14", "Aug 15", "Aug 16", "Aug 17", "Aug 18", "Aug 19", "Aug 20", "Aug 21", "Aug 22", "Aug 23", "Aug 24", "Aug 25", "Aug 26", "Aug 27", "Aug 28", "Aug 29", "Aug 30", "Aug 31",
				"Sep 01", "Sep 02", "Sep 03", "Sep 04", "Sep 05", "Sep 06", "Sep 07", "Sep 08", "Sep 09", "Sep 10", "Sep 11", "Sep 12", "Sep 13", "Sep 14", "Sep 15", "Sep 16", "Sep 17", "Sep 18", "Sep 19", "Sep 20", "Sep 21", "Sep 22", "Sep 23", "Sep 24", "Sep 25", "Sep 26", "Sep 27", "Sep 28", "Sep 29", "Sep 30",
				"Oct 01", "Oct 02", "Oct 03", "Oct 04", "Oct 05", "Oct 06", "Oct 07", "Oct 08", "Oct 09", "Oct 10", "Oct 11", "Oct 12", "Oct 13", "Oct 14", "Oct 15", "Oct 16", "Oct 17", "Oct 18", "Oct 19", "Oct 20", "Oct 21", "Oct 22", "Oct 23", "Oct 24", "Oct 25", "Oct 26", "Oct 27", "Oct 28", "Oct 29", "Oct 30", "Oct 31"]
const CALENDAR = ["Nov 01", "Nov 02", "Nov 03", "Nov 04", "Nov 05", "Nov 06", "Nov 07", "Nov 08", "Nov 09", "Nov 10", "Nov 11", "Nov 12", "Nov 13", "Nov 14", "Nov 15", "Nov 16", "Nov 17", "Nov 18", "Nov 19", "Nov 20", "Nov 21", "Nov 22", "Nov 23", "Nov 24", "Nov 25", "Nov 26", "Nov 27", "Nov 28", "Nov 29", "Nov 30",
				"Dec 01", "Dec 02", "Dec 03", "Dec 04", "Dec 05", "Dec 06", "Dec 07", "Dec 08", "Dec 09", "Dec 10", "Dec 11", "Dec 12", "Dec 13", "Dec 14", "Dec 15", "Dec 16", "Dec 17", "Dec 18", "Dec 19", "Dec 20", "Dec 21", "Dec 22", "Dec 23", "Dec 24", "Dec 25", "Dec 26", "Dec 27", "Dec 28", "Dec 29", "Dec 30", "Dec 31",
				"Jan 01", "Jan 02", "Jan 03", "Jan 04", "Jan 05", "Jan 06", "Jan 07", "Jan 08", "Jan 09", "Jan 10", "Jan 11", "Jan 12", "Jan 13", "Jan 14", "Jan 15", "Jan 16", "Jan 17", "Jan 18", "Jan 19", "Jan 20", "Jan 21", "Jan 22", "Jan 23", "Jan 24", "Jan 25", "Jan 26", "Jan 27", "Jan 28", "Jan 29", "Jan 30", "Jan 31",
				"Feb 01", "Feb 02", "Feb 03", "Feb 04", "Feb 05", "Feb 06", "Feb 07", "Feb 08", "Feb 09", "Feb 10", "Feb 11", "Feb 12", "Feb 13", "Feb 14", "Feb 15", "Feb 16", "Feb 17", "Feb 18", "Feb 19", "Feb 20", "Feb 21", "Feb 22", "Feb 23", "Feb 24", "Feb 25", "Feb 26", "Feb 27", "Feb 28",
				"Mar 01", "Mar 02", "Mar 03", "Mar 04", "Mar 05", "Mar 06", "Mar 07", "Mar 08", "Mar 09", "Mar 10", "Mar 11", "Mar 12", "Mar 13", "Mar 14", "Mar 15", "Mar 16", "Mar 17", "Mar 18", "Mar 19", "Mar 20", "Mar 21", "Mar 22", "Mar 23", "Mar 24", "Mar 25", "Mar 26", "Mar 27", "Mar 28", "Mar 29", "Mar 30", "Mar 31",
				"Apr 01", "Apr 02", "Apr 03", "Apr 04", "Apr 05", "Apr 06", "Apr 07", "Apr 08", "Apr 09", "Apr 10", "Apr 11", "Apr 12", "Apr 13", "Apr 14", "Apr 15", "Apr 16", "Apr 17", "Apr 18", "Apr 19", "Apr 20", "Apr 21", "Apr 22", "Apr 23", "Apr 24", "Apr 25", "Apr 26", "Apr 27", "Apr 28", "Apr 29", "Apr 30",
				"May 01", "May 02", "May 03", "May 04", "May 05", "May 06", "May 07", "May 08", "May 09", "May 10", "May 11", "May 12", "May 13", "May 14", "May 15", "May 16", "May 17", "May 18", "May 19", "May 20", "May 21", "May 22", "May 23", "May 24", "May 25", "May 26", "May 27", "May 28", "May 29", "May 30", "May 31",
				"Jun 01", "Jun 02", "Jun 03", "Jun 04", "Jun 05", "Jun 06", "Jun 07", "Jun 08", "Jun 09", "Jun 10", "Jun 11", "Jun 12", "Jun 13", "Jun 14", "Jun 15", "Jun 16", "Jun 17", "Jun 18", "Jun 19", "Jun 20", "Jun 21", "Jun 22", "Jun 23", "Jun 24", "Jun 25", "Jun 26", "Jun 27", "Jun 28", "Jun 29", "Jun 30",
				"Jul 01", "Jul 02", "Jul 03", "Jul 04", "Jul 05", "Jul 06", "Jul 07", "Jul 08", "Jul 09", "Jul 10", "Jul 11", "Jul 12", "Jul 13", "Jul 14", "Jul 15", "Jul 16", "Jul 17", "Jul 18", "Jul 19", "Jul 20", "Jul 21", "Jul 22", "Jul 23", "Jul 24", "Jul 25", "Jul 26", "Jul 27", "Jul 28", "Jul 29", "Jul 30", "Jul 31",
				"Aug 01", "Aug 02", "Aug 03", "Aug 04", "Aug 05", "Aug 06", "Aug 07", "Aug 08", "Aug 09", "Aug 10", "Aug 11", "Aug 12", "Aug 13", "Aug 14", "Aug 15", "Aug 16", "Aug 17", "Aug 18", "Aug 19", "Aug 20", "Aug 21", "Aug 22", "Aug 23", "Aug 24", "Aug 25", "Aug 26", "Aug 27", "Aug 28", "Aug 29", "Aug 30", "Aug 31",
				"Sep 01", "Sep 02", "Sep 03", "Sep 04", "Sep 05", "Sep 06", "Sep 07", "Sep 08", "Sep 09", "Sep 10", "Sep 11", "Sep 12", "Sep 13", "Sep 14", "Sep 15", "Sep 16", "Sep 17", "Sep 18", "Sep 19", "Sep 20", "Sep 21", "Sep 22", "Sep 23", "Sep 24", "Sep 25", "Sep 26", "Sep 27", "Sep 28", "Sep 29", "Sep 30",
				"Oct 01", "Oct 02", "Oct 03", "Oct 04", "Oct 05", "Oct 06", "Oct 07", "Oct 08", "Oct 09", "Oct 10", "Oct 11", "Oct 12", "Oct 13", "Oct 14", "Oct 15", "Oct 16", "Oct 17", "Oct 18", "Oct 19", "Oct 20", "Oct 21", "Oct 22", "Oct 23", "Oct 24", "Oct 25", "Oct 26", "Oct 27", "Oct 28", "Oct 29", "Oct 30", "Oct 31"]


@export var trick_or_treater: PackedScene
@export var money: int = 1000:
	set(value):
		if money != value:
			_money_changed(value)
		money = value
@export var shop_items: Array[ShopItem]
@export var atlas_tots: Array[Tot]
@export_multiline var game_over_text: String


var phase: int = 0:
	set(value):
		if phase != value:
			_change_phase(value)
		phase = value
var halloween_counter: int = 0
var tot_interval: float = 10.0:
	set(value):
		tot_interval = clampf(value, 1.0, 10.0)
var cursor_pos: Vector2 = SCREEN_CENTER + Vector2(8.0, 0.0):
	set(value):
		cursor_pos = value.clamp(Vector2(8.0, 24.0), Vector2(152.0, 120.0))
var fast_cursor_check := false
var fast_cursor_ready := false
var cursor_enabled := true:
	set(value):
		if cursor_enabled != value:
			_set_cursor_enabled(value)
		cursor_enabled = value
var inventory_index: int = 0:
	set(value):
		value = wrapi(value, 0, shop_items.size())
		if inventory_index != value:
			_inventory_index_changed(value)
		inventory_index = value
var current_shop_item: ShopItem
var waiting_for_halloween_to_end := false
var on_grass := false
var decoration_locations: Dictionary = {}
var hovered_decoration: Decoration:
	set(value):
		if hovered_decoration != value:
			_hovered_decoration_changed(value)
		hovered_decoration = value
var shop_open := false:
	set(value):
		if shop_open != value:
			_change_shop_open(value)
		shop_open = value
var current_tab: int = 0:
	set(value):
		if current_tab != value:
			_current_tab_changed(value)
		current_tab = value
var inventory: Dictionary
var current_shop_selection: ShopItem
var group_2: float = GROUP_2_INTERVAL
var group_3: float = GROUP_3_INTERVAL
var group_4: float = GROUP_4_INTERVAL
var group_5: float = GROUP_5_INTERVAL
var witch_counter: float = WITCH_INTERVAL
var candy: int = 100:
	set(value):
		if candy != value:
			_candy_changed(value)
		candy = maxi(value, 0)
var game_over := false
var tots_scared: int = 0
var money_spent: int = 0
var game_started := false:
	set(value):
		if game_started != value:
			_game_started_changed(value)
		game_started = value
var music_fade_out := false


@onready var cursor = $Cursor

@onready var timer_cursor = $TimerCursor
@onready var timer_fast_cursor = $TimerFastCursor
@onready var timer_building_phase = $TimerBuildingPhase
@onready var timer_halloween_phase = $TimerHalloweenPhase
@onready var timer_spawn = $TimerSpawn
@onready var label_money = $CanvasLayer/UX/HBoxContainerMoney/LabelMoney
@onready var label_candy = $CanvasLayer/UX/HBoxContainerCandy/LabelCandy
@onready var label_item_name = $Cursor/CursorLabels/LabelItemName
@onready var label_item_cost = $Cursor/CursorLabels/LabelItemCost
@onready var label_num_owned = $Cursor/CursorLabels/LabelNumOwned
@onready var h_box_container_shop = $CanvasLayer/UX/HBoxContainerShop
@onready var panel_shop = $CanvasLayer/UX/HBoxContainerShop/PanelShop
@onready var item_list_custom = $CanvasLayer/UX/HBoxContainerShop/PanelShop/VBoxContainer/ItemListCustom
@onready var shop_world = $CanvasLayer/UX/HBoxContainerShop/PanelShop/VBoxContainer/ItemListCustom/SubViewportItems/ShopWorld
@onready var atlas_world = $CanvasLayer/UX/HBoxContainerShop/PanelShop/VBoxContainer/ItemListCustom/SubViewportItems/AtlasWorld
@onready var texture_rect_shop = $CanvasLayer/UX/HBoxContainerShop/Tabs/TextureRectShop
@onready var texture_rect_atlas = $CanvasLayer/UX/HBoxContainerShop/Tabs/TextureRectAtlas
@onready var rich_text_description = $CanvasLayer/UX/HBoxContainerShop/PanelShop/VBoxContainer/MarginContainer/HBoxContainer/MarginContainer/RichTextDescription
@onready var panel_container_skip_check = $CanvasLayer/UX/PanelContainerSkipCheck
@onready var panel_container_game_over = $CanvasLayer/UX/PanelContainerGameOver
@onready var rich_text_label_game_over = $CanvasLayer/UX/PanelContainerGameOver/RichTextLabelGameOver
@onready var v_box_sell = $CanvasLayer/UX/HBoxContainerShop/PanelShop/VBoxContainer/MarginContainer/HBoxContainer/VBoxSell
@onready var v_box_buy = $CanvasLayer/UX/HBoxContainerShop/PanelShop/VBoxContainer/MarginContainer/HBoxContainer/VBoxBuy

@onready var sprite_icon = $Cursor/SpriteIcon
@onready var tile_map_layer = $TileMapLayer
@onready var tots_and_decor = $TotsAndDecor
@onready var sprite_range = $Cursor/SpriteRange
@onready var audio_stream_player_placed = $AudioStreamPlayerPlaced
@onready var audio_stream_player_buy = $AudioStreamPlayerBuy
@onready var audio_stream_player_sell = $AudioStreamPlayerSell
@onready var audio_stream_player_browse = $AudioStreamPlayerBrowse
@onready var audio_stream_player_game_over = $AudioStreamPlayerGameOver
@onready var panel_container_title = $CanvasLayer/UX/PanelContainerTitle
@onready var panel_container_press_to_start = $CanvasLayer/UX/PanelContainerPressToStart
@onready var animation_player_intro = $AnimationPlayerIntro
@onready var timer_start_game_flashing = $CanvasLayer/UX/PanelContainerPressToStart/TimerStartGameFlashing
@onready var v_box_confirm = $CanvasLayer/UX/PanelContainerPressToStart/VBoxConfirm
@onready var audio_stream_player_music = $AudioStreamPlayerMusic
@onready var panel_container_date = $CanvasLayer/UX/PanelContainerDate
@onready var label_date = $CanvasLayer/UX/PanelContainerDate/LabelDate
@onready var animation_player_date = $AnimationPlayerDate
@onready var timer_hide_date = $TimerHideDate
@onready var h_box_k = $CanvasLayer/UX/HBoxK
@onready var h_box_l = $CanvasLayer/UX/HBoxL



# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player_intro.play("intro")
	panel_container_press_to_start.visible = false
	label_money.text = str(money)
	label_candy.text = str(candy)
	current_shop_item = shop_items[inventory_index]
	sprite_range.scale = Vector2(1.0, 1.0) * (current_shop_item.radius / 16.0)
	label_item_name.text = current_shop_item.name
	label_item_cost.text = "cost: %s" % current_shop_item.cost
	if current_shop_item.icon_size == 0:
		sprite_icon.offset.y = -DECOR_Y_OFFSET
	elif current_shop_item.icon_size == 1:
		sprite_icon.offset.y = 0.0
	sprite_icon.texture = current_shop_item.icon
	
	for item in shop_items:
		inventory[item] = 0
	
	shop_world.items = shop_items
	atlas_world.tots = atlas_tots
	atlas_world.visible = false
	
	h_box_k.visible = false
	h_box_l.visible = false
	
	h_box_container_shop.visible = false
	panel_container_game_over.visible = false


func _unhandled_input(event):
	if game_over:
		if event.is_action_pressed("a"):
			get_tree().reload_current_scene()
	elif not game_started:
		if event.is_action_pressed("start") and panel_container_press_to_start.visible:
			game_started = true
	else:
		if event.is_action_pressed("start") and phase == 0:
			shop_open = false
			if panel_container_skip_check.visible:
				phase = 1
				panel_container_skip_check.visible = false
				audio_stream_player_buy.play()
			else:
				panel_container_skip_check.visible = true
				audio_stream_player_browse.play()
		
		if event.is_action_pressed("select") and phase == 0:
			if panel_container_skip_check.visible:
				panel_container_skip_check.visible = false
				audio_stream_player_sell.play()
			else:
				shop_open = not shop_open
				audio_stream_player_browse.play()
		
		if shop_open:
			if Input.is_action_just_pressed("down"):
				current_tab = 1
				#audio_stream_player_browse.play()
			if Input.is_action_just_pressed("up"):
				current_tab = 0
				#audio_stream_player_browse.play()
			
			if current_tab == 0:
				if Input.is_action_just_pressed("b"):
					if inventory[current_shop_selection] > 0:
						inventory[current_shop_selection] -= 1
						money += current_shop_selection.cost
						rich_text_description.text = current_shop_selection.description
						rich_text_description.text = rich_text_description.text.replace("xxx", str(inventory[current_shop_selection]))
						print("selling")
						audio_stream_player_sell.play()
				if Input.is_action_just_pressed("a"):
					if money >= current_shop_selection.cost:
						inventory[current_shop_selection] += 1
						money -= current_shop_selection.cost
						money_spent += current_shop_selection.cost
						rich_text_description.text = current_shop_selection.description
						rich_text_description.text = rich_text_description.text.replace("xxx", str(inventory[current_shop_selection]))
						print("buying")
						audio_stream_player_buy.play()
				
		
		if cursor_enabled and not shop_open:
			if Input.is_action_just_pressed("b") and not hovered_decoration:
				inventory_index += 1
				audio_stream_player_browse.play()
			
			if Input.is_action_just_pressed("a") and on_grass and not hovered_decoration:
				if inventory[current_shop_item] > 0:
					inventory[current_shop_item] -= 1
					label_num_owned.text = str(inventory[current_shop_item])
					var new_decoration = current_shop_item.item_scene.instantiate()
					tots_and_decor.add_child(new_decoration)
					new_decoration.global_position = cursor_pos
					if current_shop_item.icon_size == 0:
						new_decoration.global_position.y -= DECOR_Y_OFFSET
					decoration_locations[Vector2i(cursor_pos)] = new_decoration
					print("new decoration")
					audio_stream_player_placed.play()
			
			if Input.is_action_just_pressed("down"):
				cursor_pos.y += CURSOR_STEP
				fast_cursor_check = true
				fast_cursor_ready = false
				timer_cursor.start()
			if Input.is_action_just_pressed("up"):
				cursor_pos.y -= CURSOR_STEP
				fast_cursor_check = true
				fast_cursor_ready = false
				timer_cursor.start()
			if Input.is_action_just_pressed("left"):
				cursor_pos.x -= CURSOR_STEP
				fast_cursor_check = true
				fast_cursor_ready = false
				timer_cursor.start()
			if Input.is_action_just_pressed("right"):
				cursor_pos.x += CURSOR_STEP
				fast_cursor_check = true
				fast_cursor_ready = false
				timer_cursor.start()
			
			if Input.is_action_just_released("down"):
				fast_cursor_check = false
				fast_cursor_ready = false
			if Input.is_action_just_released("up"):
				fast_cursor_check = false
				fast_cursor_ready = false
			if Input.is_action_just_released("left"):
				fast_cursor_check = false
				fast_cursor_ready = false
			if Input.is_action_just_released("right"):
				fast_cursor_check = false
				fast_cursor_ready = false
			
			if fast_cursor_ready:
				if Input.is_action_pressed("down"):
					cursor_pos.y += CURSOR_STEP
					fast_cursor_check = true
					fast_cursor_ready = false
					timer_fast_cursor.start()
				if Input.is_action_pressed("up"):
					cursor_pos.y -= CURSOR_STEP
					fast_cursor_check = true
					fast_cursor_ready = false
					timer_fast_cursor.start()
				if Input.is_action_pressed("left"):
					cursor_pos.x -= CURSOR_STEP
					fast_cursor_check = true
					fast_cursor_ready = false
					timer_fast_cursor.start()
				if Input.is_action_pressed("right"):
					cursor_pos.x += CURSOR_STEP
					fast_cursor_check = true
					fast_cursor_ready = false
					timer_fast_cursor.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not game_over:
		if cursor_enabled:
			cursor.global_position = cursor_pos
			on_grass = is_on_grass(cursor_pos)
			if decoration_locations.has(Vector2i(cursor_pos)):
				hovered_decoration = decoration_locations[Vector2i(cursor_pos)]
			else:
				hovered_decoration = null
		if phase == 0 and game_started:
			if fmod(float(halloween_counter), 4.0) == 0.0:
				var time_left = timer_building_phase.time_left
				var date_idx = floori(remap(-time_left, -60.0, 0.0, 0.0, 365.9))
				label_date.text = CALENDAR_LEAP[date_idx]
			else:
				var time_left = timer_building_phase.time_left
				var date_idx = floori(remap(-time_left, -60.0, 0.0, 0.0, 364.9))
				label_date.text = CALENDAR[date_idx]
	if music_fade_out:
		audio_stream_player_music.volume_db -= delta * 5.0
		if audio_stream_player_music.volume_db < -20.0:
			audio_stream_player_music.stop()
			music_fade_out = false


func _game_started_changed(value: bool):
	if value:
		animation_player_date.play("show_date")
		timer_building_phase.start()
		panel_container_title.visible = false
		panel_container_press_to_start.visible = false
		audio_stream_player_buy.play()
		h_box_k.visible = true
		h_box_l.visible = true


func _game_over():
	print("game over")
	game_over = true
	panel_container_game_over.visible = true
	var txt = game_over_text
	txt = txt.replace("#years", str(halloween_counter))
	txt = txt.replace("#scared", str(tots_scared))
	txt = txt.replace("#money", str(money_spent))
	rich_text_label_game_over.text = txt


func _money_changed(value: int):
	label_money.text = str(value)


func _candy_changed(value: int):
	if value < 0:
		_game_over()
	label_candy.text = str(maxi(value, 0))


func _current_tab_changed(value: int):
	var shoptext: AtlasTexture = texture_rect_shop.texture
	var atlastext: AtlasTexture = texture_rect_atlas.texture
	if value == 0:
		shop_world.visible = true
		atlas_world.visible = false
		shop_world.open = true
		atlas_world.open = false
		shoptext.region.position.x = 16.0
		atlastext.region.position.x = 32.0
		texture_rect_shop.z_index = 1
		texture_rect_atlas.z_index = 0
		v_box_buy.visible = true
		v_box_sell.visible = true
	else:
		shop_world.visible = false
		atlas_world.visible = true
		shop_world.open = false
		atlas_world.open = true
		shoptext.region.position.x = 0.0
		atlastext.region.position.x = 48.0
		texture_rect_shop.z_index = 0
		texture_rect_atlas.z_index = 1
		v_box_buy.visible = false
		v_box_sell.visible = false


func _change_shop_open(value: bool):
	h_box_container_shop.visible = value
	h_box_k.visible = not value
	h_box_l.visible = not value
	if value:
		if current_tab == 0:
			shop_world.open = true
		else:
			atlas_world.open = true
	else:
		shop_world.open = false
		atlas_world.open = false
	if not value:
		label_num_owned.text = str(inventory[current_shop_item])
	else:
		if current_tab == 0:
			rich_text_description.text = current_shop_selection.description
			rich_text_description.text = rich_text_description.text.replace("xxx", str(inventory[current_shop_selection]))


func _hovered_decoration_changed(value: Decoration):
	if value:
		sprite_icon.visible = false
		#sprite_range.visible = true
		sprite_range.scale = Vector2(1.0, 1.0) * ((value.range * value.group_range_bonus) / 16.0)
		label_item_name.text = value._name
		label_item_cost.text = "cost: %s" % current_shop_item.cost
	else:
		sprite_icon.visible = true
		#sprite_range.visible = false
		sprite_range.scale = Vector2(1.0, 1.0) * ((current_shop_item.radius) / 16.0)
		label_item_name.text = current_shop_item.name
		label_item_cost.text = "cost: %s" % current_shop_item.cost


func _on_timer_spawn_timeout():
	if phase == 1 and not waiting_for_halloween_to_end:
		var group_increment = pow(float(halloween_counter), 0.5)
		group_2 -= group_increment
		group_3 -= group_increment
		group_4 -= group_increment
		group_5 -= group_increment
		witch_counter -= group_increment
		var type = 0
		if witch_counter <= 0.0:
			witch_counter += WITCH_INTERVAL
			type = 1
		
		if group_2 <= 0.0:
			group_2 += GROUP_2_INTERVAL
			for i in 2:
				_spawn_tot(type)
		elif group_3 <= 0.0:
			group_3 += GROUP_3_INTERVAL
			for i in 3:
				_spawn_tot(type)
		elif group_4 <= 0.0:
			group_4 += GROUP_4_INTERVAL
			for i in 4:
				_spawn_tot(type)
		elif group_5 <= 0.0:
			group_5 += GROUP_5_INTERVAL
			for i in 5:
				_spawn_tot(type)
		else:
			_spawn_tot(type)


func _spawn_tot(type: int):
	var new_tot = trick_or_treater.instantiate()
	new_tot.type = type
	tots_and_decor.add_child(new_tot)
	new_tot.spooked.connect(_on_tot_spooked)
	new_tot.global_position.y = -1.0
	new_tot.global_position.x = randf_range(8.0, 152.0)
	timer_spawn.start(tot_interval)


func _on_tot_spooked():
	tots_scared += 1


func _inventory_index_changed(value: int):
	if label_item_name:
		current_shop_item = inventory.keys()[value]
		label_item_name.text = current_shop_item.name
		label_item_cost.text = "cost: %s" % current_shop_item.cost
		label_num_owned.text = str(inventory[current_shop_item])
		if current_shop_item.icon_size == 0:
			sprite_icon.offset.y = -DECOR_Y_OFFSET
		elif current_shop_item.icon_size == 1:
			sprite_icon.offset.y = 0.0
		if current_shop_item.name == "Jack-O-Lantern":
			sprite_icon.offset.y -= 2.0
		if current_shop_item.name == "Tombstone":
			sprite_icon.offset.y -= 4.0
		sprite_icon.texture = current_shop_item.icon
		sprite_range.scale = Vector2(1.0, 1.0) * (current_shop_item.radius / 16.0)


func _change_phase(value: int):
	if not game_over:
		if value == 0:# build
			h_box_k.visible = true
			h_box_l.visible = true
			animation_player_date.play("show_date")
			for dm in get_tree().get_nodes_in_group("dropped_money"):
				dm.queue_free()
				money += 10
			for dc in get_tree().get_nodes_in_group("dropped_candy"):
				dc.queue_free()
				candy += 1
			timer_building_phase.start()
			cursor_enabled = true
			waiting_for_halloween_to_end = false
			#sprite_range.visible = true
			print("building phase")
			music_fade_out = true
		else:# halloween
			h_box_k.visible = false
			h_box_l.visible = false
			timer_hide_date.start()
			label_date.text = "Oct 31"
			for ts in get_tree().get_nodes_in_group("tombstone"):
				var damage_bonus = 1.0
				var range_bonus = 1.0
				for ots in get_tree().get_nodes_in_group("tombstone"):
					if ts != ots:
						var dist = ts.global_position.distance_squared_to(ots.global_position)
						var strength_boost = 1.0 + ((1.0 - remap(clampf(dist, 256.0, 3600.0), 256.0, 3600.0, 0.0, 1.0)) * 0.04)
						damage_bonus *= strength_boost
						range_bonus *= strength_boost
				ts.group_damage_bonus = damage_bonus
				ts.group_range_bonus = range_bonus
			
			if not timer_building_phase.is_stopped():
				timer_building_phase.stop()
			timer_halloween_phase.start()
			cursor_enabled = false
			shop_open = false
			halloween_counter += 1
			var counter_remapped = float(halloween_counter) * 0.01
			var counter_pow_0p5 = pow(float(halloween_counter), 0.5)
			#tot_interval = MAX_TOT_INTERVAL - (counter_remapped * 9.0)
			tot_interval = MAX_TOT_INTERVAL / counter_pow_0p5
			timer_spawn.start(tot_interval)
			print("halloween phase")
			music_fade_out = false
			audio_stream_player_music.volume_db = -3.2
			audio_stream_player_music.play()


func is_on_grass(point: Vector2) -> bool:
	var tdata = tile_map_layer.get_cell_tile_data(tile_map_layer.local_to_map(tile_map_layer.to_local(Vector2i(point))))
	if tdata:
		return tdata.get_custom_data("grass")
	return false


func _set_cursor_enabled(value: bool):
	cursor.visible = value


func _on_timer_cursor_timeout():
	fast_cursor_ready = fast_cursor_check


func _on_timer_fast_cursor_timeout():
	fast_cursor_ready = fast_cursor_check


func _on_timer_building_phase_timeout():
	phase = 1


func _on_timer_halloween_phase_timeout():
	if get_tree().get_node_count_in_group("tot") > 0:
		waiting_for_halloween_to_end = true
		print("waiting for halloween to end")
	else:
		phase = 0
		print("halloween is over")


func _on_child_exiting_tree(node):
	print("child exiting tree")
	if waiting_for_halloween_to_end:
		if node.is_in_group("tot"):
			if get_tree().get_node_count_in_group("tot") <= 1:
				phase = 0


func _on_shop_world_current_item(item: ShopItem):
	current_shop_selection = item
	rich_text_description.text = item.description
	rich_text_description.text = rich_text_description.text.replace("xxx", str(inventory[current_shop_selection]))
	if shop_open:
		audio_stream_player_browse.play()


func _on_porch_body_entered(body):
	if body.is_in_group("tot"):
		if body.type == 0:
			candy -= 2
		elif body.type == 1:
			candy -= 3


func _on_tots_and_decor_child_exiting_tree(node):
	print("child exiting tree")
	if waiting_for_halloween_to_end:
		if node.is_in_group("tot"):
			if get_tree().get_node_count_in_group("tot") <= 1:
				phase = 0


func _on_atlas_world_current_tot(tot: Tot):
	rich_text_description.text = tot.description
	if shop_open:
		audio_stream_player_browse.play()


func _on_animation_player_intro_animation_finished(anim_name):
	if anim_name == "intro":
		panel_container_press_to_start.visible = true
		timer_start_game_flashing.start()


func _on_timer_start_game_flashing_timeout():
	v_box_confirm.visible = not v_box_confirm.visible


func _on_timer_hide_date_timeout():
	animation_player_date.play("hide_date")
