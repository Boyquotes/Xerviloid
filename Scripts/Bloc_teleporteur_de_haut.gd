extends Node2D

export var position_joueur = Vector2()
var zone_tele

func _ready():
	$Zone_tele.position= Vector2(position_joueur.x-position.x,position_joueur.y-position.y+16)

func _on_Zone_tele_body_entered(body):

	zone_tele=body


func _on_Zone_tele_body_exited(body):
	if body==zone_tele :
		zone_tele=null

func _on_Bloc_joueur_body_entered(body):
	if "Joueur" in body.name   and (zone_tele==null or zone_tele==body):
		body.position = position_joueur
