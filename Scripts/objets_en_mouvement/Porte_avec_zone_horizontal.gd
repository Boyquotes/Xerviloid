extends "res://Scripts/objets_en_mouvement/Objet_bouge.gd"


var vecteur_deplacement = Vector2()
export var position_finale = 150.00
var gauche = false
var count_corps=0
var position_initiale

# Called when the node enters the scene tree for the first time.
func _ready():
	 position_initiale = position.x
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (position.x < position_finale and not gauche) or (gauche and position.x > position_initiale):
		move_and_slide(vecteur_deplacement)
	$RayCast2D.force_raycast_update()
	#on veut pouvoir pousser des blocks avec la porte
	if $RayCast2D.is_colliding() and ("Objet" in $RayCast2D.get_collider().name or "Joueur" in $RayCast2D.get_collider().name):
		$RayCast2D.get_collider().move_and_slide(vecteur_deplacement)
		


func _on_Bouton_body_entered(body):
	if "Joueur" in body.name or "Objet" in body.name :
		count_corps+=1
		gauche = false
		vecteur_deplacement = Vector2(128,0)


func _on_Bouton_body_exited(body):
	if "Joueur" in body.name or "Objet" in body.name :
		count_corps-=1
		if count_corps==0:
			gauche = true
			vecteur_deplacement = Vector2(-128,0)

