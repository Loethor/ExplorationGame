extends Camera2D


## ZOOMING CODE ##
# yoink : https://www.gdquest.com/tutorial/godot/2d/camera-zoom/

# Lower cap for the `_zoom_level`.
export var min_zoom := 0.5
# Upper cap for the `_zoom_level`.
export var max_zoom := 2.0
# Controls how much we increase or decrease the `_zoom_level` on every turn of the scroll wheel.
export var zoom_factor := 0.1
# Duration of the zoom's tween animation.
export var zoom_duration := 0.2

# The camera's target zoom level.
var _zoom_level := 1.0 setget _set_zoom_level

# We store a reference to the scene's tween node.
onready var tween: Tween = $Tween

func _set_zoom_level(value: float) -> void:
	# We limit the value between `min_zoom` and `max_zoom`
	_zoom_level = clamp(value, min_zoom, max_zoom)
	# Then, we ask the tween node to animate the camera's `zoom` property from its current value
	# to the target zoom level.
	tween.interpolate_property(
		self,
		"zoom",
		zoom,
		Vector2(_zoom_level, _zoom_level),
		zoom_duration,
		tween.TRANS_SINE,
		# Easing out means we start fast and slow down as we reach the target value.
		tween.EASE_OUT
	)
	tween.start()
	
func _unhandled_input(event):
	if event.is_action_pressed("zoom_in"):
		# Inside a given class, we need to either write `self._zoom_level = ...` or explicitly
		# call the setter function to use it.
		_set_zoom_level(_zoom_level - zoom_factor)
	if event.is_action_pressed("zoom_out"):
		_set_zoom_level(_zoom_level + zoom_factor)
	
## END OF ZOOMING CODE ##

## DRAGGING CODE ##
# yoink https://godotengine.org/qa/24969/how-to-drag-camera-with-mouse

var mouse_start_pos
var screen_start_position

var dragging = false
func _input(event):
	if event.is_action("drag"):
		if event.is_pressed():
			mouse_start_pos = event.position
			screen_start_position = position
			dragging = true
		else:
			dragging = false
	elif event is InputEventMouseMotion and dragging:
		position = zoom * (mouse_start_pos - event.position) + screen_start_position


## END OF DRAGGING CODE ##

## EDGE SCROLL CODE ## 
# yoink: https://github.com/carmel4a/RTS-Camera2D/blob/master/addons/carmel4a97.RTS_Camera2D/RTS-Camera2D.gd

# Camera speed in px/s.
export (int) var camera_speed = 450 

# Value meaning how near to the window edge (in px) the mouse must be,
# to move a view.
export (int) var camera_margin = 100
var camera_movement = Vector2()

# Previous mouse position used to count delta of the mouse movement.
var _prev_mouse_pos = null
export var dragging_enabled = false

func _process(delta):

		#TODO fix bug
	var rec = get_viewport().get_visible_rect()
	var v = get_local_mouse_position() + rec.size/2
	
	if rec.size.x - v.x <= camera_margin:
		camera_movement.x += camera_speed * delta
	if v.x <= camera_margin:
		camera_movement.x -= camera_speed * delta
	if rec.size.y - v.y <= camera_margin:
		camera_movement.y += camera_speed * delta
	if v.y <= camera_margin:
		camera_movement.y -= camera_speed * delta
		
	# Update position of the camera.
	if dragging_enabled:
		position += camera_movement * get_zoom()
	
	# Set camera movement to zero, update old mouse position.
	camera_movement = Vector2(0,0)
	_prev_mouse_pos = get_local_mouse_position()
	
	
## END OF EDGE SCROLLING ##
