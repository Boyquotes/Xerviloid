extends "res://Scripts/objets_en_mouvement/gravité/objets_gravite.gd"

var raycastG
var raycastD


# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	set_physics_process(true)
	raycastG =$RayCastG
	raycastD =$RayCastD


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	direction.x = int(pousse_joueur(raycastD))-int(pousse_joueur(raycastG))
	velocity.x = (direction.x*speed)
		
	
	if  sur_porte() : 
		velocity.y=-128
	if snap:
		move_and_slide_with_snap(velocity,Vector2(0,1),Vector2(0,-1))
	else:
		move_and_slide(velocity, Vector2(0,-1))#Vector2(velocity.x,0)


#retourne vrai si le joueur1 pousse directement ou indirectement le block
func pousse_joueur(raycast):
	raycast.force_raycast_update()
	return raycast.is_colliding() and(( "ObjetRaycast" in raycast.get_collider().name and raycast.get_collider().pousse_joueur(raycast))or ( "Joueur1" in raycast.get_collider().name))
