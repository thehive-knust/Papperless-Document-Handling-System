import 'package:path/path.dart';
import 'package:softdoc/sqflite_db/Department_db/approval_fields.dart';
import 'package:sqflite/sqflite.dart';
import 'user_model.dart';
import 'user_fields.dart';

class UserDatabase {
  static final UserDatabase instance = UserDatabase._init();

  static Database _database;

  UserDatabase._init();

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
    final deptID ='FOREIGN KEY ("${UserFields.deptID}") REFERENCES ${DepartmentFields.id}';



    await db.execute('''
  CREATE TABLE $tableUser ( 
  ${UserFields.id} $idType, 
  ${UserFields.name} $textType,
  ${UserFields.deptID} $deptID,
  )
  ''');
  }

  Future<User> create(User user) async {
    final db = await instance.database;

    final id = await db.insert(tableUser, user.toMap());
    return user.copy(id: id);
  }

  /// Retrieving data from the database

  Future<User> readUser(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableUser,
      columns: UserFields.values,
      where: '${UserFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return User.fromMapTo(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }
  /// Reading/Retrieving all data from the database

  Future<List<User>> readAllUsers() async {
    final db = await instance.database;

    final orderBy = '${UserFields.name} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableUser, orderBy: orderBy);

    return result.map((json) => User.fromMapTo(json)).toList();
  }


 ///  Updating data into Database
  Future<int> update(User user) async {
    final db = await instance.database;

    return db.update(
      tableUser,
      user.toMap(),
      where: '${UserFields.id} = ?',
      whereArgs: [user.id],
    );
  }

  /// deleting data from database

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableUser,
      where: '${UserFields.id} = ?',
      whereArgs: [id],
    );
  }
/// closing of database
  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
