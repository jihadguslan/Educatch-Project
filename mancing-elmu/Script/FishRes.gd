extends Resource
class_name IkanResource

@export var id_ikan : int = 0
@export_enum("common", "rare", "epic", "legendary")
var rarity : int
@export var nama_ikan : String
@export var image_ikan : Texture2D
@export_multiline var deskripsi_ikan : String
@export var harga_ikan : int
@export var posibility : int
var button_tex : Array[Texture2D] = [preload("uid://qwqhhfpf5ef3"), preload("uid://cpvlayb5qv1at"), preload("uid://besk25giuar10"), preload("uid://ce6v8qp807an3")]
