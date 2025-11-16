extends Resource
class_name BaitResource

@export var bait_name : String = "Nama Bait"
@export var kode_soal : String = ""
@export var id : int = 0
@export var price : int = 0
@export var bait_image : Texture2D
@export_multiline var deskripsi : String = ""
@export var soal_get : Array[Resource]
@export var fish_get : Array[Resource]
