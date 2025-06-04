extends Node2D


@export var slots: Array[ConveyorItem]  

const COPPER = preload("res://assets/copper.png")
var item_pos = self.position.x

var direction = Vector2.LEFT
@onready var canvas_layer: CanvasLayer = $CanvasLayer


func _ready() -> void:
	update_items()


func _draw() -> void:
	if slots[0]: 
		draw_texture(slots[0].texture, Vector2(position.x - slots[0].progress * 16, position.y + 8))
	if slots[1]: 
		draw_texture(slots[1].texture, Vector2(position.x - slots[1].progress * 16, position.y))
	if slots[2]: 
		draw_texture(slots[2].texture, Vector2(position.x - slots[2].progress * 16, position.y - 8))
	


func _process(delta: float) -> void:
	item_pos += 1 * delta * 20
	


func update_items():
	var i = 0
	for item: ConveyorItem in slots:
		if item == null:
			pass
		else:
			if slots[i - 1] == null:
				print("plus 5")
				item.progress += 0.5
		i += 1
	queue_redraw()
		
