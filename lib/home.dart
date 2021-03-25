import 'dbhelper.dart';
import 'entryform.dart';
import 'barang.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<Mahasiswa> mahasiswaList;

  @override
  Widget build(BuildContext context) {
    if (mahasiswaList == null) {
      mahasiswaList = List<Mahasiswa>();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Data Mahasiswa'),
      ),
      body: createListView(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Tambah Data',
        onPressed: () async {
          var mahasiswa = await navigateToEntryForm(context, null);
          if (mahasiswa != null) addMahasiswa(mahasiswa);
        },
      ),
    );
  }

  Future<Mahasiswa> navigateToEntryForm(
      BuildContext context, Mahasiswa mahasiswa) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryForm(mahasiswa);
    }));
    return result;
  }

  ListView createListView() {
    TextStyle textStyle = Theme.of(context).textTheme.subtitle1;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(Icons.people),
            ),
            title: Text(
              this.mahasiswaList[index].nama,
              style: textStyle,
            ),
            subtitle: Text(this.mahasiswaList[index].harga),
            trailing: GestureDetector(
              child: Icon(Icons.delete),
              onTap: () {
                deleteMahasiswa(mahasiswaList[index]);
              },
            ),
            onTap: () async {
              var mahasiswa =
                  await navigateToEntryForm(context, this.mahasiswaList[index]);
              if (mahasiswa != null) editMahasiswa(mahasiswa);
            },
          ),
        );
      },
    );
  }

  //buat mahasiswa
  void addMahasiswa(Mahasiswa object) async {
    int result = await dbHelper.insert(object);
    if (result > 0) {
      updateListView();
    }
  }

  //edit mahasiswa
  void editMahasiswa(Mahasiswa object) async {
    int result = await dbHelper.update(object);
    if (result > 0) {
      updateListView();
    }
  }

  //delete mahasiswa
  void deleteMahasiswa(Mahasiswa object) async {
    int result = await dbHelper.delete(object.id);
    if (result > 0) {
      updateListView();
    }
  }

  //update mahasiswa
  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      Future<List<Mahasiswa>> mahasiswaListFuture = dbHelper.getMahasiswaList();
      mahasiswaListFuture.then((mahasiswaList) {
        setState(() {
          this.mahasiswaList = mahasiswaList;
          this.count = mahasiswaList.length;
        });
      });
    });
  }
}