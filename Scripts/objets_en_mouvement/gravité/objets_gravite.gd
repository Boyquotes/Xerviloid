extends "res://Scripts/objets_en_mouvement/Base_Joueur.gd"

var raycastB
var raycastB2
var velocity= Vector2() 
var snap

func _ready():
	raycastB=$RayCastB
	raycastB2=$RayCast2B

#fonction qui determine si le joueur est sur une porte directement
func sur_porte():
	raycastB.force_raycast_update()
	if raycastB.is_colliding() and "Porte_bouton" in raycastB.get_collider().name and raycastB.get_collider().position.y>raycastB.get_collider().position_finale and not raycastB.get_collider().descend:
		return true
	raycastB2.force_raycast_update()
	if raycastB2.is_colliding() and "Porte_bouton" in raycastB2.get_collider().name and raycastB2.get_collider().position.y>raycastB2.get_collider().position_finale and not raycastB2.get_collider().descend:
		return true
		
#fonction qui determine si le joueur est sur une porte directement ou indirectement ex joueur2 est sur joueur1 et joueur1 est sur une porte
func touche_porte():
	raycastB.force_raycast_update()
	if raycastB.is_colliding() and(sur_porte() or (("ObjetRaycast" in raycastB.get_collider().name or "Joueur" in raycastB.get_collider().name)and raycastB.get_collider().touche_porte())):
		return true
		
	raycastB2.force_raycast_update()
	if raycastB2.is_colliding() and(sur_porte() or (("ObjetRaycast" in raycastB2.get_collider().name or "Joueur" in raycastB2.get_collider().name)and raycastB2.get_collider().touche_porte())):
		return true

#si 1 joueur est sur un autre joueur on retourne le joueur
func touchejoueur():
	raycastB.force_raycast_update()
	raycastB2.force_raycast_update()

	if raycastB.is_colliding() and "Joueur" in raycastB.get_collider().name:
		return raycastB.get_collider()
	if raycastB2.is_colliding() and "Joueur" in raycastB2.get_collider().name:
		return  raycastB2.get_collider()
func _physics_process(delta):

	#on veut que le joueur arrete de monter lorsqu'il frappe une surface en sautant
	if is_on_ceiling():
		velocity.y = gravity*delta
	var joueur = touchejoueur()
	if is_on_floor() or joueur!=null:
		#$antSprite.flip_v=false
		snap=true
		velocity.y = 0
		if joueur!=null:
			var pos=joueur.position.y
			if "Joueur" in name:
				position.y=pos -65
			else: position.y=pos -49
				
	else:
		velocity.y += gravity*delta
		snap = false
	
	if is_on_wall():velocity.x=0

