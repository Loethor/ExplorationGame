extends "res://scenes/rooms/BaseCell.gd"

#onready var has_top_wall : bool = true
#onready var has_left_wall : bool = false
#onready var has_right_wall : bool = true
#onready var has_bottom_wall : bool = false

func _ready():
	self.has_top_wall  = true
	self.has_left_wall = false
	self.has_right_wall = true
	self.has_bottom_wall  = false
