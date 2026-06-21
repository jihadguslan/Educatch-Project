extends Node

@export var csvPath : Array[String]
#@export var nama_soal : String = ""

func _ready() -> void:
	_on_file_selected()

func _on_file_selected():
	var output_dir = "res://Soal Res/"
	DirAccess.make_dir_recursive_absolute(output_dir)
	if csvPath.is_empty() : return
	for i in csvPath :
		if i == "" : continue
		var nama_soal = i.erase(0, 34).erase(3, 4)
		var file = FileAccess.open(i, FileAccess.READ)
		if not file :
			push_error("CSV tidak ditemukan!")
			return
		var line_index = 0
		while file.get_position() < file.get_length():
			var line = file.get_line()
			line_index += 1
			if line_index == 1:
				continue
			var cells = line.split(";")
			print(cells )
			if cells.size() < 7 :
				push_error("Baris kurang (Tambahkan baris hingga jadi 7 baris)")
				continue
			var res := SoalResource.new()
			res.id_soal = int(cells[0])
			var difficulty = 0
			match cells[1] :
				"SD" : difficulty = 0 
				"SMP" : difficulty = 1
				"SMA" : difficulty = 2 
			res.difficulty = difficulty
			res.isi_soal = cells[2]
			var jawaban_int = {"A" : 0, "B" : 1, "C" : 2, "D" : 3}
			res.pilihan_soal[0] = cells[3]
			res.pilihan_soal[1] = cells[4]
			res.pilihan_soal[2] = cells[5]
			res.pilihan_soal[3] = cells[6]
			res.jawaban_soal = jawaban_int[cells[7]]
			
			var save_path = output_dir + cells[1] + "_" + nama_soal + "_" + cells[0] + ".tres"
			ResourceSaver.save(res, save_path)
			#print("Saved : " + save_path)
		print("Import CSV Selesai!!!")
