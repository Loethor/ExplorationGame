class_name TopRightCell extends BaseCell

func _ready():
	self.has_top_wall  = true
	self.has_left_wall = false
	self.has_right_wall = true
	self.has_bottom_wall  = false
