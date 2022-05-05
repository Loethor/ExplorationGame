class_name BottomRightLeftCell extends BaseCell

func _ready():
	self.has_top_wall  = false
	self.has_left_wall = true
	self.has_right_wall = true
	self.has_bottom_wall  = true
