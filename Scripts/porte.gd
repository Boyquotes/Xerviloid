
extends Area2D
export (String) var pathendroit
var nb_joueurs
var count =0

# Called when the node enters the scene tree for the first time.
func _ready():
	nb_joueurs= get_owner().get_child(0).get_child_count()

#lorsque tout les joueurs sont dans la porte, on change de scene
func _on_porte_body_entered(body):
	if "Joueur" in body.name:
		count+=1
		if count == nb_joueurs:
			Global.goto_scene(pathendroit)


func _on_porte_body_exited(body):
	if "Joueur" in body.name:
		count-=1
