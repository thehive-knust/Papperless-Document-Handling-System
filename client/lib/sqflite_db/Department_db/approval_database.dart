import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'approval_model.dart';
import 'approval_fields.dart';

class DepartmentDatabase {
  static final DepartmentDatabase instance = DepartmentDatabase._init();

  static Database _database;

  DepartmentDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDB('department.db');
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
  CREATE TABLE $tableDepartment ( 
  ${DepartmentFields.id} $idType, 
  ${DepartmentFields.name} $textType,
  )
  ''');
  }

  Future<Department> create(Department department) async {
    final db = await instance.database;

    final id = await db.insert(tableDepartment, department.toMap());
    return department.copy(id: id);
  }

  /// Retrieving data from the database

  Future<Department> readDepartment(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableDepartment,
      columns: DepartmentFields.values,
      where: '${DepartmentFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Department.fromMapTo(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }
  /// Reading/Retrieving all data from the database

  Future<List<Department>> readAllDepartments() async {
    final db = await instance.database;

    final orderBy = '${DepartmentFields.name} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableDepartment, orderBy: orderBy);

    return result.map((json) => Department.fromMapTo(json)).toList();
  }


 ///  Updating data into Database
  Future<int> update(Department department) async {
    final db = await instance.database;

    return db.update(
      tableDepartment,
      department.toMap(),
      where: '${DepartmentFields.id} = ?',
      whereArgs: [department.id],
    );
  }

  /// deleting data from database

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableDepartment,
      where: '${DepartmentFields.id} = ?',
      whereArgs: [id],
    );
  }
/// closing of database
  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
