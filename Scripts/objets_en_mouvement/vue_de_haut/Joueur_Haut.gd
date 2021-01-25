extends "res://Scripts/objets_en_mouvement/Base_Joueur.gd"


var destination = Vector2()
var origine = Vector2()
#raycast vers le bas
var raycastB
#raycast horizontal
var raycastD
var tween
signal undo
var vitesse = 0.20
var z=false
var position_precedente

# Called when the node enters the scene tree for the first time.
func _ready():

	raycastB = $RayCastB
	raycastD= $RayCastD
	tween = $Tween
	connect("undo",Global,"undo")
	position_precedente=position
func _physics_process(delta):

	if est_joueur_courant: 
		#on ne veut pas annuler un mouvement lorsque le joueur est entrain de tween
		if Input.is_action_pressed("z"):
			z=true
		#tween is active ne fonctionne pas, donc on regarde si le joueur est dans une case de la grid
		elif position-Vector2(int(position.x),int(position.y))==Vector2() and (int(position.x)+16)%32==0 and int(position.y)%32==0:
			z=false
		if z:
			emit_signal("undo")
			
		elif position_precedente!=position :
			#si on est pas entrain de undo et qu'on se deplace, on enregistre les positions
			Global.emit_signal("action")
			position_precedente=position

