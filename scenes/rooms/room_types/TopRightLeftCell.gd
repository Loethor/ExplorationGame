class_name TopRightLeftCell extends BaseCell

func _ready():
	self.has_top_wall  = true
	self.has_left_wall = true
	self.has_right_wall = true
	self.has_bottom_wall  = false