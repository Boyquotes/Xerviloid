extends "res://Scripts/objets_en_mouvement/Objet_bouge.gd"

var vecteur_deplacement = Vector2()
export var position_finale = 150.00
var descend = true
var count_corps=0
var position_initiale

# Called when the node enters the scene tree for the first time.
func _ready():
	position_initiale = position.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if (position.y > position_finale or (descend and position_initiale> position.y)) :
		move_and_slide(vecteur_deplacement)

#quand on utilise plusieurs portes dans la meme scene
#pour ne pas avoir à refaire  plusieurs signals avec une signature différente
#il fautr mettre le  bouton child de la porte, connecter le signal
#puis enlever le boutton du parent

#la porte monte lorsqu'au moins un corps est present dans la zone du bouton associé à la porte
func _on_Bouton_body_entered(body):
	if "Joueur" in body.name or "Objet" in body.name :
		count_corps+=1
		descend = false
		vecteur_deplacement = Vector2(0,-128)
	
#la porte descend lorsqu'il n'y a aucun corps dans la zone du bouton
func _on_Bouton_body_exited(body):
	if "Joueur" in body.name or "Objet" in body.name :
		count_corps-=1
		if count_corps==0:
			descend = true
			vecteur_deplacement = Vector2(0,128)
			








func _on_Area2D_body_entered(body):
	if "Joueur" in body.name or "Objet" in body.name and descend:
		vecteur_deplacement = Vector2()



func _on_Area2D_body_exited(body):
	if ("Joueur" in body.name or "Objet" in body.name) and descend:
		vecteur_deplacement = Vector2(0,128)






