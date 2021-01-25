extends KinematicBody2D

signal sauvegarde_terminee

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.connect("action",self,"sauvegarde_position")
	connect("sauvegarde_terminee",Global,"sauvegarde_pour_undo")
	Global.nb_corps+=1

#on sauvegarde les parametres de chaque objets qui se deplacent
#on utilise cette sauvegarde dans le undo
func sauvegarde_position():
	
	if "Plateforme_M" in name:
		Global.objets_scene_courrante.push_back([self,position,self.accum,self.avance,self.timer_fini])

	elif "Joueur" in name: 
		Global.objets_scene_courrante.push_back([self,position,self.camera,self.est_joueur_courant])
	else:
		Global.objets_scene_courrante.push_back([self,position])

	if Global.nb_corps==(Global.objets_scene_courrante.size()):
		emit_signal("sauvegarde_terminee")
	

