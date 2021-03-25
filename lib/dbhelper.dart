import 'barang.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DbHelper {
  static DbHelper _dbHelper;
  static Database _database;  

  DbHelper._createObject();

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }
    return _dbHelper;
  }

  Future<Database> initDb() async {

  //untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'mahasiswa.db';

   //create, read databases
    var todoDatabase = openDatabase(path, version: 1, onCreate: _createDb);

    //mengembalikan nilai object sebagai hasil dari fungsinya
    return todoDatabase;
  }

    //buat tabel baru dengan nama mahasiswa
  void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE mahasiswa (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT,
        harga TEXT
      )
    ''');
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }

  Future<List<Map<String, dynamic>>> select() async {
    Database db = await this.database;
    var mapList = await db.query('mahasiswa', orderBy: 'nama');
    return mapList;
  }

//create databases
  Future<int> insert(Mahasiswa object) async {
    Database db = await this.database;
    int count = await db.insert('mahasiswa', object.toMap());
    return count;
  }
//update databases
  Future<int> update(Mahasiswa object) async {
    Database db = await this.database;
    int count = await db.update('mahasiswa', object.toMap(), 
                                where: 'id=?',
                                whereArgs: [object.id]);
    return count;
  }

//delete databases
  Future<int> delete(int id) async {
    Database db = await this.database;
    int count = await db.delete('mahasiswa', 
                                where: 'id=?', 
                                whereArgs: [id]);
    return count;
  }

  Future<List<Mahasiswa>> getMahasiswaList() async {
    var mahasiswaMapList = await select();
    int count = mahasiswaMapList.length;
    List<Mahasiswa> mahasiswaList = List<Mahasiswa>();
    for (int i=0; i<count; i++) {
      mahasiswaList.add(Mahasiswa.fromMap(mahasiswaMapList[i]));
    }
    return mahasiswaList;
  }

}