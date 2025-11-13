extends Resource
class_name SoalResource

@export var id_soal : int = 0
@export_enum("SD", "SMP", "SMA")
var difficulty : int
@export_multiline var isi_soal : String
@export var pilihan_soal : Array[String] = ["", "", "", ""]
@export_enum("A", "B", "C", "D") var jawaban_soal : int
