import 'package:flutter/material.dart';
import 'barang.dart';

class EntryForm extends StatefulWidget {
  final Mahasiswa mahasiswa;

  EntryForm(this.mahasiswa);

  @override
  EntryFormState createState() => EntryFormState(this.mahasiswa);
}

class EntryFormState extends State<EntryForm> {
  EntryFormState(this.mahasiswa);

  Mahasiswa mahasiswa;
  TextEditingController namaController = TextEditingController();
  TextEditingController nimController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //kondisi
    if (mahasiswa != null) {
      namaController.text = mahasiswa.nama;
      nimController.text = mahasiswa.harga;
    }
    //ubah
    return Scaffold(
        appBar: AppBar(
          title: mahasiswa == null ? Text('Tambah') : Text('Ubah'),
          leading: Icon(Icons.keyboard_arrow_left),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[
              // nama
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: namaController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Nama Lengkap',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),

              // nim
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: nimController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'NIM',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),

              // tombol button
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Row(
                  children: <Widget>[
                    // tombol simpan
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Save',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          if (mahasiswa == null) {
                            // tambah data
                            mahasiswa = Mahasiswa(
                                namaController.text, nimController.text);
                          } else {
                            // ubah data
                            mahasiswa.nama = namaController.text;
                            mahasiswa.harga = nimController.text;
                          }
                          // kembali ke layar sebelumnya dengan membawa objek mahasiswa
                          Navigator.pop(context, mahasiswa);
                        },
                      ),
                    ),
                    Container(
                      width: 5.0,
                    ),
                    // tombol batal
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Cancel',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}