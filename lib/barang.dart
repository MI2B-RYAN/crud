class Mahasiswa {
  int id;
  String nama;
  String harga;

  // konstruktor versi 1
  Mahasiswa(this.nama, this.harga);

  // konstruktor versi 2: konversi dari Map ke Contact
  Mahasiswa.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nama = map['nama'];
    harga = map['harga'];
  }

  // konversi dari Contact ke Map
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['id'] = this.id;
    map['nama'] = this.nama;
    map['harga'] = this.harga;
    return map;
  }
}