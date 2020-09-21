import 'package:path/path.dart' as path;
import '../models/transaction.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';

class DBHelper {
  //db File name
  static final _dbName = "MyDb.db";
  //Chnage the version Incase you want to change the Schema
  static final _dbVersion = 1;

//Make a Singleton class;
  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();

//Allow only a Singleton to Open Database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  //defining _initDatabase
  _initDatabase() async {
    String dbPath = await sql.getDatabasesPath();
    return await sql.openDatabase(path.join(dbPath, _dbName),
        version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''Create table $tName(
      $colId integer , 
      $colName text not null, 
      $colCategory text not null, 
      $colAmount integer not null)''');
  }

  //Insert Data
  Future<int> insert(Transactions transaction) async {
    Database db = await database;
    int id = await db.insert(tName, transaction.toMap());
    return id;
  }

//Fetching Data from the Table as List<Transactions>:
  Future<List> getAllRecords(String tName) async {
    Database db = await database;
    var result = await db.query(tName);
    return result.toList();
  }

//Selecting Data => Return a Single Entry
  Future<Transactions> queryTransaction(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(
      tName,
      columns: [colId, colName, colAmount],
    );

    if (maps.length > 0) {
      return Transactions.fromMap(maps.first);
    }
    return null;
  }

  Future<void> deleteTransaction(int id) async {
    // Get a reference to the database.
    Database db = await database;

    // Remove the Dog from the Database.
    await db.delete(
      'dogs',
      // Use a `where` clause to delete a specific dog.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  Future<void> truncateTable(String tName) async {
    // Get a reference to the database.
    Database db = await database;
    await db.rawQuery('delete from  $tName');
  }

}
