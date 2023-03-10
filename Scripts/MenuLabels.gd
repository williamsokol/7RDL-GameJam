extends Label



export var hoveredButtonP:NodePath
export var nonHoveredButtonP:NodePath

var hoverFeatures:Dictionary
var nonHoverFeatures:Dictionary
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	self.connect("mouse_entered", self, "on_mouse_entered")
	self.connect("mouse_exited", self, "on_mouse_exited")
	
	var hB = get_node(hoveredButtonP)
	hoverFeatures ={
		"font_color":hB.get_color("font_color"),
		"font_color_shadow":hB.get_color("font_color_shadow"),
		"shadow_offset_x":hB.get_constant("shadow_offset_x"),
		"shadow_offset_y":hB.get_constant("shadow_offset_y")
	}

	var nHB = get_node(nonHoveredButtonP)
	nonHoverFeatures ={
		"font_color":nHB.get_color("font_color"),
		"font_color_shadow":nHB.get_color("font_color_shadow"),
		"shadow_offset_x":nHB.get_constant("shadow_offset_x"),
		"shadow_offset_y":nHB.get_constant("shadow_offset_y")
	}
	
func on_mouse_entered():
	print("hovering")
	makeSelected()
func on_mouse_exited():
	print("hovering")
	makeDeSelected()
func makeSelected():
	pass
	self.add_color_override("font_color",hoverFeatures["font_color"])
	self.add_color_override("font_color_shadow",hoverFeatures["font_color_shadow"])
	self.add_constant_override("shadow_offset_x",hoverFeatures["shadow_offset_x"])
	self.add_constant_override("shadow_offset_y",hoverFeatures["shadow_offset_y"])
	#self.add_color_override(feat)
func makeDeSelected():
	self.add_color_override("font_color",nonHoverFeatures["font_color"])
	self.add_color_override("font_color_shadow",nonHoverFeatures["font_color_shadow"])
	self.add_constant_override("shadow_offset_x",nonHoverFeatures["shadow_offset_x"])
	self.add_constant_override("shadow_offset_y",nonHoverFeatures["shadow_offset_y"])
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass 


