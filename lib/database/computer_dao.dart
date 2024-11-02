import 'package:sqflite/sqflite.dart';
import '../models/computer_model.dart';
import 'database_helper.dart';

class ComputerDao {
  static final ComputerDao _instance = ComputerDao._internal();
  factory ComputerDao() => _instance;
  ComputerDao._internal();

  Future<Database> get database async {
    return await DatabaseHelper().database;
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
