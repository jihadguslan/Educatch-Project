extends Resource
class_name SoalResource

enum DifficultType{SD, SMP, SMA}
const DifficultString = ["SD", "SMP", "SMA"]

@export var id_soal : int = 0
@export var difficulty : DifficultType
@export_multiline var isi_soal : String
@export var pilihan_soal : Array[String] = ["", "", "", ""]
@export_enum("A", "B", "C", "D") var jawaban_soal : int
