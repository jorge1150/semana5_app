import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/computer_model.dart';

class ComputerDao {
  static final ComputerDao _instance = ComputerDao._internal();
  static Database? _database;

  factory ComputerDao() {
    return _instance;
  }

  ComputerDao._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'computers.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE computers(id INTEGER PRIMARY KEY AUTOINCREMENT, processor TEXT, hardDrive TEXT, ram TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<List<Computer>> fetchComputers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('computers');

    return List.generate(maps.length, (i) {
      return Computer(
        id: maps[i]['id'],
        processor: maps[i]['processor'],
        hardDrive: maps[i]['hardDrive'],
        ram: maps[i]['ram'],
      );
    });
  }

  Future<void> insertComputer(Computer computer) async {
    final db = await database;
    await db.insert(
      'computers',
      computer.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateComputer(Computer computer) async {
    final db = await database;
    await db.update(
      'computers',
      computer.toMap(),
      where: 'id = ?',
      whereArgs: [computer.id],
    );
  }

  Future<void> deleteComputer(int id) async {
    final db = await database;
    await db.delete(
      'computers',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
