import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'approval_model.dart';
import 'approval_fields.dart';

class ApprovalDatabase {
  static final ApprovalDatabase instance = ApprovalDatabase._init();

  static Database _database;

  ApprovalDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDB('users.db');
    return _database;
  }


  /// Opens database connection

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createTable);
  }



  Future _createTable(Database db, int version) async {

    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';




    await db.execute('''
  CREATE TABLE $tableUser ( 
  ${ApprovalFields.id} $idType, 
  ${ApprovalFields.status} $textType,
  )
  ''');
  }

  Future<Approval> create(Approval document) async {
    final db = await instance.database;

    final id = await db.insert(tableUser, document.toMap());
    return document.copy(id: id);
  }

  /// Retrieving data from the database

  Future<Approval> readDocument(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableUser,
      columns: ApprovalFields.values,
      where: '${ApprovalFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Approval.fromMapTo(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }
  /// Reading/Retrieving all data from the database

  Future<List<Approval>> readAllUsers() async {
    final db = await instance.database;

    final orderBy = '${ApprovalFields.status} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableUser, orderBy: orderBy);

    return result.map((json) => Approval.fromMapTo(json)).toList();
  }


 ///  Updating data into Database
  Future<int> update(Approval user) async {
    final db = await instance.database;

    return db.update(
      tableUser,
      user.toMap(),
      where: '${ApprovalFields.id} = ?',
      whereArgs: [user.id],
    );
  }

  /// deleting data from database

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableUser,
      where: '${ApprovalFields.id} = ?',
      whereArgs: [id],
    );
  }
/// closing of database
  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
