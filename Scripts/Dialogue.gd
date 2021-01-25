extends Node2D
var dialogue_path
var dialogue
var nom
var texte
var cle=0
func _ready():
	nom=$Sprite.get_child(0)
	texte=$Sprite.get_child(1)
	dialogue_path = get_parent().path
	_load()
	set_process(false)
	hide()



func _load():
	var f = File.new()
	f.open(dialogue_path, File.READ)
	var texte = f.get_as_text()
	dialogue = parse_json(texte)
	f.close()

func charge_text():
	if not cle>dialogue.size()-1:#verifie si la cle n'est pas trop grande
		nom.set_text(dialogue[cle]["Nom"])
		texte.set_text(dialogue[cle]["Texte"])
		cle+=1
	else:
		hide()
		set_process(false)

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		charge_text()




#on lance le dialogue lorsqu'on s'approche du npc
func _on_NPC_body_entered(body):
	if "Joueur" in body.name and cle==0:
		charge_text()
		show()
		set_process(true)
