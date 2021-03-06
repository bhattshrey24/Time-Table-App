import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path1;
import 'dart:async';
import 'package:path_provider/path_provider.dart' as path2;
import 'dart:io' as io;

class AppDB {
  static sql.Database _db;

  static Future<sql.Database> database() async {
    // this method creates the database
    if (_db != null) {
      return _db;
    }
    _db = await AppDB._initDB();
    return _db;
  } // remember you cant have a coulumn name with space eg 'student name'is wrong instead have a name 'student_name'

  static _initDB() async {
    io.Directory documentsDirectory = await path2
        .getApplicationDocumentsDirectory(); // THIS RETURNS PATH TO PLACE WHERE WE'LL STORE THE DB
    var pathOFDB = path1.join(documentsDirectory.path, 'timetable2.db');
    var db =
        await sql.openDatabase(pathOFDB, version: 1, onCreate: AppDB._createDB);
    return db;
  }

  static _createDB(sql.Database db, int newVersion) async {
    //these three qoutes ''' enables us to write String like the way it is written below , now even after beautificaion it wont realign in a single line
    await db.execute(
        'CREATE TABLE time_table(id INTEGER PRIMARY KEY AUTOINCREMENT,type TEXT,startingTime TEXT,endingTime TEXT,iconType TEXT,noOfHours INT,noOfMinutes INT)');
    print('inside createDB');
  }

  static Future<int> insert(String tableName, Map<String, Object> data) async {
    // this method inserts the data in database
    print('inside insert');
    final db = await AppDB.database();

    return db.insert(tableName, data,
        conflictAlgorithm: sql.ConflictAlgorithm
            .replace); // conflic argument is used cause if we already have a entery with an id then it overwrites the data with new data
  }

  static Future<List<Map<String, dynamic>>> getData(String tableName) async {
    print('inside getdata');
    //this method is to fetch/get data from database
    final db = await AppDB
        .database(); // we have to explicitly do classname.function_name cause it is static method and if we dont do this it will find this function as global method
    return db.query(tableName); // return raw querry which joins both the table
  }
}
