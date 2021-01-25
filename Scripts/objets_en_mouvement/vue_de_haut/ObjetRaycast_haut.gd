extends "res://Scripts/objets_en_mouvement/Objet_bouge.gd"

var direction = Vector2()
var vitesse=0.20

var raycastB
var raycastH
var raycastD
var raycastG
var joueur1
var tween

func _ready():
	set_process(true)
	set_physics_process(true)
	if "de_haut" in get_owner().get_child(0).get_child(0).name:
		joueur1=get_owner().get_child(0).get_child(0)
	else:
		joueur1=get_owner().get_child(1).get_child(0)
	raycastB=$RayCastB
	raycastH=$RayCastH
	raycastD=$RayCastD
	raycastG=$RayCastG
	tween=$Tween

func _physics_process(delta):

	if joueur1.est_joueur_courant and joueur1.avance: #solution batard #on pourrait mettre le block inactif quand personne est dans la salle
		
		if joueur1.direction.x >0 and( pousse_joueur(raycastG,6) and not peut_pas_bouger(raycastD,5)):
			deplace(Vector2(Global.GRID_TAILLE, 0))
			
		elif joueur1.direction.x <0 and( pousse_joueur(raycastD,5) and not peut_pas_bouger(raycastG,6) ) :
			deplace(Vector2(-Global.GRID_TAILLE, 0))
		elif  joueur1.direction.y <0 and (pousse_joueur(raycastB,3) and not peut_pas_bouger(raycastH,4)):
			deplace(Vector2(0,-Global.GRID_TAILLE))
		elif  joueur1.direction.y >0 and (pousse_joueur(raycastH,4)and not peut_pas_bouger(raycastB,3) ):
			deplace(Vector2(0,Global.GRID_TAILLE))
		
	
#determine si le block doit etre immobilisé
func peut_pas_bouger(raycast,child):
	raycast.force_raycast_update()
	return raycast.is_colliding()  and(("TileMap" in raycast.get_collider().name)or ( "ObjetRaycast" in raycast.get_collider().name and raycast.get_collider().peut_pas_bouger(raycast.get_collider().get_child(child), child)))

	
func deplace(vecteur):
	tween.interpolate_property(self, 'position', position , position + vecteur, vitesse, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

#retourne vrai lorsque lorsque le joueur1 touche directement ou insirectement le block 
func pousse_joueur(raycast,child):
	raycast.force_raycast_update()
	return raycast.is_colliding() and(( "Joueur1" in raycast.get_collider().name) or ( "ObjetRaycast" in raycast.get_collider().name and raycast.get_collider().pousse_joueur(raycast.get_collider().get_child(child), child)))

