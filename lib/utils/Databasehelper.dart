import 'package:milk_register/models/Milk.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';


class DatabaseHelper {

  static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
  static Database _database;                // Singleton Database

  String milkTable = 'Milk_table';
  String colId = 'id';
  String colDay = 'day';
  String colMonth = 'month';
  String colYear = 'year';
  String colQ = 'q';
  String colDate='date';

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {
    print('in constructor');

    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    print('in get db');

    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    print('initializeDatabase');
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    print(directory.toString());
    String path = directory.path + 'milk.db';

    // Open/create the database at a given path
    var notesDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    print('open db complete');
    return notesDatabase;
  }
  Future<Database> deletedb() async {
    print('deleteDatabase');
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    print(directory.toString());
    String path = directory.path + 'milk.db';
    await deleteDatabase(path);
    // Open/create the database at a given path

    var notesDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    print('open db complete');
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    print('_createDb');

    await db.execute('CREATE TABLE $milkTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colDay TEXT, '
        '$colMonth TEXT, $colYear TEXT, $colQ DOUBLE,$colDate TEXT)');
  }

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getMilkMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(milkTable, orderBy: '$colYear ASC');
    return result;
  }

  // Insert Operation: Insert a Note object to database
  Future<int> insertMilk (Milk milk) async {
    Database db = await this.database;
    List<Milk> x= await _databaseHelper.getMilkList();

    for (Milk m in x)
      {
        if(m.date==milk.date)
          {
            var result = await db.update(milkTable, milk.toMap(), where: '$colDate = ?', whereArgs: [milk.date]);
            return result;
          }
      }

    var result = await db.insert(milkTable, milk.toMap());
    return result;
  }

  // Update Operation: Update a Note object and save it to database
  Future<int> updateMilk (Milk milk) async {
    var db = await this.database;
    var result = await db.update(milkTable, milk.toMap(), where: '$colDate = ?', whereArgs: [milk.date]);
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteMilk (int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $milkTable WHERE $colId = $id');
    return result;
  }

  // Get number of Note objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $milkTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<Milk>> getMilkList() async {

    var milkMapList = await getMilkMapList(); // Get 'Map List' from database
    int count = milkMapList.length;         // Count the number of map entries in db table

    List<Milk> milkList = List<Milk>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      milkList.add(Milk.fromMapObject(milkMapList[i]));
    }

    return milkList;
  }

}

