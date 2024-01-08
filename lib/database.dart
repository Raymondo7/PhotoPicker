import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'gallery.db');
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE photos (
        id INTEGER PRIMARY KEY,
        file TEXT
      )
    ''');

  }

  Future<int> insertPhoto(Photo photo) async {
    Database db = await database;
    return await db.insert('photos', photo.toMap());
  }

  Future<List<Photo>> getAllPhotos() async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query('photos');
    return result.map((map) => Photo.fromMap(map)).toList();
  }

  Future<int> updatePhoto(Photo photo) async {
    Database db = await database;
    return await db.update('photos', photo.toMap(),
        where: 'id = ?', whereArgs: [photo.id]);
  }

  Future<int> deletePhoto(int id) async {
    Database db = await database;
    return await db.delete('photos', where: 'id = ?', whereArgs: [id]);
  }
}


class Photo {
  int? id;
  String file;

  Photo({this.id, required this.file});

  Map<String, dynamic> toMap() {
    return {'id': id, 'file': file};
  }

  factory Photo.fromMap(Map<String, dynamic> map) {
    return Photo(id: map['id'], file: map['file']); // Utilisez 'file' ici
  }
}
