import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        description TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }
// id: the id of a item
// title, description: name and description of your activity
// created_at: the time that the item was created. It will be automatically handled by SQLite

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'Character.db',
      version: 1,
    );
  }

  // Create new item (journal)
  static Future<int> createItem(String title, String? descrption) async {
    final db = await SQLHelper.db();

    final data = {'title': title, 'description': descrption};
    final id = await db.insert('items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all items (journals)
  static Future<List<Map<String, dynamic>>> getItems(String table,int id) async {
    final dbpath= await sql.getDatabasesPath();
    print(dbpath);
    final path=join(dbpath,"Character.db");
    final exist=await sql.databaseExists(path);
    print(exist);
    if(false){
      try{
        await Directory(dirname(path)).create(recursive: true);
      }catch(_){}
      ByteData data=await rootBundle.load(join("assets","Character.db"));
      List<int> bytes=data.buffer.asInt8List(data.offsetInBytes,data.lengthInBytes);
      await File(path).writeAsBytes(bytes,flush: true);
      await sql.openDatabase(path);
      print("db copied");
    }
    final db = await SQLHelper.db();
    List<Map<String, dynamic>> result=await db.query(table,where: "id = ?", whereArgs: [id], limit: 1);
    print(result.runtimeType);
    if(result==Null){
      print("result is null");
    }else if (result=="Null"){
      print("result is null");
    }
    return result;
  }

  // Read a single item by id
  // The app doesn't use this method but I put here in case you want to see it
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    var dbContent = await rootBundle.load('assets/Character.db');
    print(dbContent);
    return db.query('items', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update an item by id
  static Future<int> updateItem(
      int id, String title, String? descrption) async {
    final db = await SQLHelper.db();

    final data = {
      'title': title,
      'description': descrption,
      'createdAt': DateTime.now().toString()
    };

    final result =
    await db.update('items', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteItem(int id, String Table) async {
    final db = await SQLHelper.db();
    try {
      await db.delete(Table, where: "id = ?", whereArgs: [id]);
      print("deleted");
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}