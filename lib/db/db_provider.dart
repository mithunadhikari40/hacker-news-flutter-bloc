import 'package:hnapp/core/constants.dart';
import 'package:hnapp/models/items_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';

import 'sources.dart';

class _DbProvider implements Sources, Cache {
  Database db;
  _DbProvider() {
    init();
  }
  Future<void> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, APP_DB);
    db = await openDatabase(path, version: 1,
        onCreate: (Database database, int verion) {
      Batch batch = database.batch();
      batch.execute("""
      CREATE TABLE $TABLE_NAME(
        id INTEGER PRIMARY KEY,
        by TEXT,
        descendants INTEGER,
        score INTEER,
        text TEXT,
        time INTEGER,
        title TEXT,
        type TEXT,
        url TEXT,
        kids BLOB,
        deleted INTEGER,
        dead INTEER,
        parent INTEGER
      )
      """);
      batch.commit();
    });
  }

  @override
  Future<int> insertItem(ItemModel itemModel) async {
    if (db == null) await init();
    return db.insert(TABLE_NAME, itemModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    // insert into Items() values()
  }

  @override
  Future<ItemModel> fetchItem(int id) async {
    if (db == null) await init();

    final data = await db.query(
      TABLE_NAME,
      columns: ['*'],
      where: "id = ?",
      whereArgs: [id],
    );

    return data.length > 0 ? ItemModel.fromDb(data.first) : null;
  }

  @override
  Future<List<int>> fetchTopIds() {
    return null;
  }

  @override
  Future<int> clearData() async {
    if (db == null) await init();

    return db.delete(TABLE_NAME);
  }
}

final dbProvider = _DbProvider();
