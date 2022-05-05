class_name LeftCell extends BaseCell

func _ready():
	self.has_top_wall  = false
	self.has_left_wall = true
	self.has_right_wall = false
	self.has_bottom_wall  = false
