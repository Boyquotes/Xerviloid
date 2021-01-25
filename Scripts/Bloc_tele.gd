extends Node2D

export var position_joueur = Vector2()

func _on_Mort_body_entered(body):
	if "Joueur" in body.name:
		body.position = position_joueur
