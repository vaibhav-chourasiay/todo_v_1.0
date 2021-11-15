import 'package:learn/models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static String dbname = "mydatabase.db";
  static String columnid = "id";
  static String columnname = "title";
  static String columnage = "des";

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database?> get database async {
    // if the database is not null
    if (_database != null) {
      return _database;
    }
    // if the database is null then initlized the database
    _database = await Initilized();

    return _database;
  }

  // ignore: non_constant_identifier_names
  Future<Database> Initilized() async {
    // FOR GET THE PATH OF DOCUMENT DIRECTORY BY USING DART:IO AS IO
    io.Directory directory = await getApplicationDocumentsDirectory();

    //JOINING DIRECTORY NAME WITH DATABASE NAME USING JOIN METHOD
    String path = join(directory.path, dbname);

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  //THEN CREATE DATABASE TABLE AND COLUMNS
  _onCreate(Database db, int version1) async {
    return await db.execute(
        'CREATE TABLE mytodo( $columnid INTEGER PRIMARY KEY, $columnname TEXT ,$columnage TEXT )');
  }

  Future<int> insetData(MyModal m) async {
    Database? db = await instance.database;

    return await db!.insert('mytodo', m.toMap());
  }

  Future<List> getdata() async {
    Database? db = await instance.database;
    List l = await db!.query("mytodo");
    return l;
  }

  Future<void> deleteData(int id) async {
    // Get a reference to the database.
    final db = await instance.database;

    // Remove the Dog from the database.
    await db!.delete(
      'mytodo',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
}
