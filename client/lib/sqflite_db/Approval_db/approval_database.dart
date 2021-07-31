import 'package:path/path.dart';
import 'package:softdoc/sqflite_db/Document_db/document_fields.dart';
import 'package:softdoc/sqflite_db/User_db/user_fields.dart';
import 'package:sqflite/sqflite.dart';
import 'approval_model.dart';
import 'approval_fields.dart';

class ApprovalDatabase {
  static final ApprovalDatabase instance = ApprovalDatabase._init();

  static Database _database;
  ApprovalDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDB('approvals.db');
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
    final foreignKey ='FOREIGN KEY ("${DocumentFields.id}") REFERENCES ${UserFields.id}';




    await db.execute('''
  CREATE TABLE $tableApprovaL ( 
  ${ApprovalFields.id} $idType, 
  ${ApprovalFields.status} $textType,
  ${ApprovalFields.docID} $foreignKey, 
  ${ApprovalFields.userID} $foreignKey, 
  )
  ''');
  }

  Future<Approval> create(Approval approval) async {
    final db = await instance.database;

    final id = await db.insert(tableApprovaL, approval.toMap());
    return approval.copy(id: id);
  }

  /// Retrieving data from the database

  Future<Approval> readApproval(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableApprovaL,
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

  Future<List<Approval>> readAllApprovals() async {
    final db = await instance.database;

    final orderBy = '${ApprovalFields.status} ASC';
    final result = await db.query(tableApprovaL, orderBy: orderBy);

    return result.map((json) => Approval.fromMapTo(json)).toList();
  }


 ///  Updating data into Database
  Future<int> update(Approval approval) async {
    final db = await instance.database;

    return db.update(
      tableApprovaL,
      approval.toMap(),
      where: '${ApprovalFields.id} = ?',
      whereArgs: [approval.id],
    );
  }

  /// deleting data from database

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableApprovaL,
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
