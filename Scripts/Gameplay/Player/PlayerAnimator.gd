extends AnimatedSprite


export var playerPath:NodePath
onready var player = get_node(playerPath)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	print(player)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if(Vector2.ZERO == player.velocity):
		playing = false
		
	else:
		playing = true
		
	if(abs(player.velocity.x)>abs(player.velocity.y)):
		animation = "Side"
		flip_h = player.velocity.x <0
		
	else:
		if(player.velocity.y<0):
			animation = "Up"
			z_index = 1
		else:
			animation = "Down"
			z_index = 0
		
