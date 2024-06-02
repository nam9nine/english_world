import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../db/db.dart';
import '../model/category-word.model.dart';

class WordRepository {
  final DatabaseHelper _databaseHelper;

  WordRepository(this._databaseHelper);

  Future<List<Word>> getWordsByCategory(String? category) async {
    if (category == null) {
      log('category를 넣어주세요');
    }
    final db = await _databaseHelper.database;
    final result = await db.query('words', where: 'category = ?', whereArgs: [category]);
    List<Word> words = result.map((map) => Word.fromMap(map)).toList();
    return words;
  }

  Future<List<Map<String, dynamic>>> getAllWords() async {
    final db = await _databaseHelper.database;
    final result = await db.query('words');
    return result;
  }
  Future<List<Word>> getWrongAnswer() async {
    final db = await _databaseHelper.database;
    final result = await db.query(
      'words',
      where: 'isWrong = ?',
      whereArgs: [1],
    );

    List<Word> words = result.map((map) => Word.fromMap(map)).toList();
    return words;
  }
  Future<void> deleteDatabaseFile() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'words.db');
    await deleteDatabase(path);
  }

  Future<void> updateWrongAnswer(String? correctWord) async {
    var db = await _databaseHelper.database;
    await db.update(
      'words',
      {'isWrong': 1},
      where: 'meaning = ?',
      whereArgs: [correctWord],
    );
  }
  Future<void> updateCorrectAnswer(String correctWord) async {
    var db = await _databaseHelper.database;
    await db.update(
      'words',
      {'isWrong' : 0},
      where : 'meaning = ?',
      whereArgs: [correctWord],
    );
  }
}