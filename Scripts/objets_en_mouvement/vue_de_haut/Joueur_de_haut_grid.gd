extends "res://Scripts/objets_en_mouvement/vue_de_haut/Joueur_Haut.gd"


var avance = false

func _ready():
	est_joueur_courant=true


func _physics_process(delta):
	if est_joueur_courant:

		if not tween.is_active():
			if direction.y==0:
				direction.x = int(Input.is_action_pressed("ui_right"))-int(Input.is_action_pressed("ui_left"))
			if direction.x==0:
				direction.y = int(Input.is_action_pressed("ui_down"))-int(Input.is_action_pressed("ui_up"))
		else: direction = Vector2()

		match direction:
			Vector2(-1,0):
				change_direction[0]= self.scale.x==-1
				self.scale.x=-1
				facing_right=-1
			Vector2(1,0):
				change_direction[0]= self.scale.x==1
				self.scale.x=1
				facing_right=1
			Vector2(0,-1):
				change_direction[1] = raycastB.scale.y==-1
				raycastB.scale.y=-1
			Vector2(0,1):
				change_direction[1] = raycastB.scale.y==1
				raycastB.scale.y=1

		raycastD.force_raycast_update()
		#je dois faire des choses étranges pour que le joueur puisse avancer en poussant des blocks, il y a surement une meilleure façon...
		if change_direction[0] and direction.x != 0 and ((not raycastD.is_colliding() or  (touche_block(raycastD) and not raycastD.get_collider().peut_pas_bouger(raycastD.get_collider().get_child(index_raycast_objet()),index_raycast_objet())))):
			avance = true
			tween.interpolate_property(self, 'position', position, position + Vector2(Global.GRID_TAILLE*direction.x, 0), vitesse, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)

		raycastB.force_raycast_update()
		if change_direction[1] and direction.y != 0 and(not raycastB.is_colliding()or (touche_block(raycastB)  and not raycastB.get_collider().peut_pas_bouger(raycastB.get_collider().get_child(index_raycast_objet()),index_raycast_objet()))):
			avance = true
			tween.interpolate_property(self, 'position', position, position + Vector2(0, Global.GRID_TAILLE*direction.y), vitesse, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)

		tween.start()
		

func touche_block(raycast):
	return raycast.is_colliding() and "ObjetRaycast"in raycast.get_collider().name

func _on_Tween_tween_completed(object, key):
	avance = false

#it just works
func index_raycast_objet():
	if direction.x!=0:
		return 5+int(direction.x<0)
	else:
		return 3  + int(direction.y<0)
