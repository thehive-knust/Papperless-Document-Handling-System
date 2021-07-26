// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'document.dart';

// class DocumentDatabase {
//   static final DocumentDatabase instance = DocumentDatabase._init();

//   static Database? _database;

//   DocumentDatabase._init();

//   Future<Database> get database async {
//     if (_database != null) return _database!;

//     _database = await _initDB('documents.db');
//     return _database!;
//   }


//   /// Opens database connection

//   Future<Database> _initDB(String filePath) async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, filePath);

//     return await openDatabase(path, version: 1, onCreate: _createTable);
//   }



//   Future _createTable(Database db, int version) async {
//     final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
//     final textType = 'TEXT NOT NULL';


//     await db.execute('''
//   CREATE TABLE $tableDocuments ( 
//   ${DocumentFields.id} $idType, 
//   ${DocumentFields.size} $textType,
//   ${DocumentFields.name} $textType,
//   ${DocumentFields.type} $textType,
//   ${DocumentFields.dateModified} $textType
//   )
//   ''');
//   }

//   Future<Document> create(Document document) async {
//     final db = await instance.database;

//     final id = await db.insert(tableDocuments, document.toJson());
//     return document.copy(id: id);
//   }

//   /// Retrieving data from the database

//   Future<Document> readDocument(int id) async {
//     final db = await instance.database;

//     final maps = await db.query(
//       tableDocuments,
//       columns: DocumentFields.values,
//       where: '${DocumentFields.id} = ?',
//       whereArgs: [id],
//     );

//     if (maps.isNotEmpty) {
//       return Document.fromJson(maps.first);
//     } else {
//       throw Exception('ID $id not found');
//     }
//   }
//   /// Reading/Retrieving all data from the database

//   Future<List<Document>> readAllNotes() async {
//     final db = await instance.database;

//     final orderBy = '${DocumentFields.dateModified} ASC';
//     // final result =
//     //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

//     final result = await db.query(tableDocuments, orderBy: orderBy);

//     return result.map((json) => Document.fromJson(json)).toList();
//   }


//  ///  Updating data into Database
//   Future<int> update(Document document) async {
//     final db = await instance.database;

//     return db.update(
//       tableDocuments,
//       document.toJson(),
//       where: '${DocumentFields.id} = ?',
//       whereArgs: [document.id],
//     );
//   }

//   /// deleting data from database

//   Future<int> delete(int id) async {
//     final db = await instance.database;

//     return await db.delete(
//       tableDocuments,
//       where: '${DocumentFields.id} = ?',
//       whereArgs: [id],
//     );
//   }
// /// closi of database
//   Future close() async {
//     final db = await instance.database;

//     db.close();
//   }
// }
