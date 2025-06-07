extends Node2D

@export var inventory: Inventory

@onready var ray_cast_1: RayCast2D = $RayCast_1
@onready var ray_cast_2: RayCast2D = $RayCast_2

var laser_1_object
var laser_2_object

var laser_1_is_mining: bool
var laser_2_is_mining: bool

var mine_speed: float = 1.0
var inventory_capacity: int = 10

var mine_timer: float = 0


@onready var texture_rect: TextureRect = $Control/TextureRect
@onready var label: Label = $Control/Label




func _physics_process(delta: float) -> void:
	var collider = ray_cast_1.get_collider()
	
	if collider and collider.get_parent() is ResourceWall: 
		inventory.conveyor_item = collider.get_parent().resource
		mine_timer += delta
		if mine_timer >= mine_speed:
			inventory.amount += 1
			mine_timer = 0
			label.text = str(inventory.amount)





func _on_control_mouse_entered() -> void:
	if inventory.conveyor_item:
		texture_rect.visible = true
		label.visible = true
		texture_rect.texture = inventory.conveyor_item.texture
		label.text = str(inventory.amount)


func _on_control_mouse_exited() -> void:
	if inventory.conveyor_item:
		texture_rect.visible = false
		label.visible = false
		
		texture_rect.texture = null
