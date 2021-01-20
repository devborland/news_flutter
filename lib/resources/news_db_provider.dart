import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import '../models/item_model.dart';

class NewsDbProvider {
  late Database db;

  init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'items.db');
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) {
        newDb.execute('''
          CREATE TABLE Items
            (
              id INTEGER PRIMARY KEY,
              type TEXT,
              by TEXT,
              time INTEGER,
              text TEXT,
              parent INTEGER,
              kids BLOB,
              dead INTEGER,
              deleted INTEGER,
              url TEXT,
              score INTEGER,
              title TEXT,
              descendants INTEGER           
            )        
        ''');
      },
    );
  }

  fetchItem(int id) async {
    final List<Map<String, dynamic>> maps = await db.query(
      'Items',
      columns: [
        'id',
        'deleted',
        'type',
        'by',
        'time',
        'text',
        'dead',
        'parent',
        'kids',
        'url',
        'score',
        'title',
        'descendants'
      ],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.length > 0) {
      return ItemModel.fromDb(maps.first);
    }
    return null;
  }

  addItem(ItemModel item) {
    return db.insert('Items', item.toMapForDb());
  }
}
