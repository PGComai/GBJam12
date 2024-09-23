extends Resource
class_name ShopItem

@export var item_scene: PackedScene
@export var name: String
@export var cost: int
@export var dps: float
@export_multiline var description: String
@export var radius: float
@export var icon: Texture2D
@export_enum("16x24", "16x16") var icon_size: int
