extends "res://scenes/rooms/BaseCell.gd"

#onready var has_top_wall = true
#onready var has_left_wall = true
#onready var has_right_wall = false
#onready var has_bottom_wall = false

func _ready():
	self.has_top_wall  = true
	self.has_left_wall = true
	self.has_right_wall = false
	self.has_bottom_wall  = false
