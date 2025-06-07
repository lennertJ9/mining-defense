extends Camera2D


var SCROLL_MARGIN_X 
var SCROLL_MARGIN_Y
const SCROLL_SPEED = 2000


func _ready() -> void:
	get_tree().get_root().size_changed.connect(update_margin)
	update_margin()


func _process(delta: float) -> void:
	var screen_center = get_viewport_rect().size / 2
	var mouse_pos = get_viewport().get_mouse_position()
	var direction := Vector2.ZERO
	var distance = mouse_pos - screen_center
	
	#if abs(distance.x) > SCROLL_MARGIN_X:
		#direction.x = sign(distance.x)
	#
	#if abs(distance.y) > SCROLL_MARGIN_Y:
		#direction.y = sign(distance.y)
	
		
	position += direction.normalized() * SCROLL_SPEED * delta


func update_margin():
	SCROLL_MARGIN_X = get_viewport_rect().size.x * 0.495
	SCROLL_MARGIN_Y = get_viewport_rect().size.y * 0.495



func zoom_in():
	zoom += Vector2(0.15,0.15)


func zoom_out():
	zoom -= Vector2(0.15,0.15)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_scroll_up"):
		zoom_in()
	if event.is_action_pressed("mouse_scroll_down"):
		zoom_out()
	
	
