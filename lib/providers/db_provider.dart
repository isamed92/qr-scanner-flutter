import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_reader/models/models.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database _database = _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();
  Future<Database> get database async {
    // if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  Future<Database> initDB() async {
    //! Path de donde almacenaremos la db
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');
    print(path);

    //! Creacion de la base de datos
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE Scans(
          id INTEGER PRIMARY KEY,
          type TEXT,
          value TEXT
        )
''');
      },
    );
  }

  //! forma convencional de insertar un registro
  Future<int> nuevoScanRaw(ScanModel newScan) async {
    final id = newScan.id;
    final type = newScan.type;
    final value = newScan.value;
    // obtener la referencia a la db
    final db = await database;

    final resp = await db.rawInsert('''
      INSERT INTO Scans (id, type, value)
      VALUES ($id, '$type', '$value')
''');
    //? resp es el id del registro
    return resp;
  }

  //? forma recomendada
  Future<int> newScan(ScanModel scan) async {
    final db = await database;

    final res = db.insert('Scans', scan.toJson());
    //? res es el id del registro
    return res;
  }
}
