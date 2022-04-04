extends "res://scenes/rooms/BaseCell.gd"

#onready var has_top_wall : bool = false
#onready var has_left_wall : bool = true
#onready var has_right_wall : bool = true
#onready var has_bottom_wall : bool = true

func _ready():
	self.has_top_wall  = false
	self.has_left_wall = true
	self.has_right_wall = true
	self.has_bottom_wall  = true
