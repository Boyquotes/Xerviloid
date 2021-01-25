extends Node
var sauvegardes_undo = []
var objets_scene_courrante=[]
const GRID_TAILLE = 32
var nb_corps=0
var racine
var joueurs
var joueurs_inactifs
var joueurs_actifs
signal action
#var camera_joueur
var next_scene =null
var peut_entrer=true


func _ready():
	var root = get_tree().get_root()
	racine = get_tree().current_scene
	joueurs = racine.get_child(0)
	joueurs_inactifs = racine.get_child(1)
	joueurs_actifs = racine.get_child(0)

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().reload_current_scene()

func goto_scene(path):
	 call_deferred("_deferred_goto_scene", path)
	

func _deferred_goto_scene(path):
	nb_corps=0 #reset au changement de niveau

	get_tree().current_scene.free()

	var s = ResourceLoader.load(path)

	next_scene = s.instance()

	get_tree().get_root().add_child(next_scene)

	get_tree().set_current_scene(next_scene)

func sauvegarde_pour_undo():#push front pop back
	var sauvegarde_tableau = objets_scene_courrante.duplicate()
	sauvegardes_undo.push_back(sauvegarde_tableau)
	objets_scene_courrante.clear()

#annule un mouvement
func undo():
	
	if not sauvegardes_undo.empty():
		var objets_sauvegarde = sauvegardes_undo.pop_back()
		if objets_sauvegarde[0][0] is bool:# reinitialise dans la sauvegarde
			defered_reparent(objets_sauvegarde[0][1])
		else:
			objets_sauvegarde.push_front([null])
		for i in range(1,objets_sauvegarde.size()-1):
			var propriete = objets_sauvegarde[i]
			var objet = propriete[0]

			if "Plateforme_M" in objet.name:
				objet.accum= propriete[2]
				objet.avance= propriete[3]
				objet.timer_fini= propriete[4]
			elif "Joueur" in objet.name:

				var camera = propriete[2]
				objet.camera=camera
				if not "inactif" in objet.get_parent().name and propriete[3]:
					camera.make_current()

			
			objet.position= propriete[1]
		

func defered_reparent(index_joueur):

	if peut_entrer:# il rentre plusieurs fois sinon..
		peut_entrer=false
		var joueur_actif = joueurs_inactifs.get_child(index_joueur)
		var joueur_inactif=joueurs_actifs.get_child(index_joueur)
		call_deferred("reparent",joueur_actif,joueur_inactif,index_joueur)
	
func reparent(actif,inactif,index_joueur):

	joueurs_inactifs.remove_child(actif)
	joueurs.add_child(actif)
	joueurs.move_child(actif,index_joueur)
	
	joueurs.remove_child(inactif)
	joueurs_inactifs.add_child(inactif)
	joueurs_inactifs.move_child(inactif,index_joueur)
	actif.set_active(true)
	inactif.set_active(false)
	actif.est_joueur_courant=true
	inactif.est_joueur_courant=false
	
	#actif.camera=camera_joueur
	actif.position=actif.position_original
	peut_entrer=true

