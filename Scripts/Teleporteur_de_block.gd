extends Area2D


export var arrive=Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	$Arrive.position=arrive

func _on_Teleporteur_de_block_body_entered(body):
	if "Objet" in body.name:
		body.position=arrive
