extends Resource
class_name IkanResource

@export var id_ikan : int = 0
@export_enum("common", "rare", "epic", "legendary", "god")
var rarity : int
@export var nama_ikan : String
@export var image_ikan : Texture2D
@export_multiline var deskripsi_ikan : String
@export var harga_ikan : int
@export var posibility : int
