// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:bloctesting/infrastructure/profile/models/post/post_model.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  Future<void> initDb() async {
    Database db;
    var NEW_DB_VERSION = 2;
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "sqlite.db");
    var exists = await databaseExists(path);
    if (!exists) {
      // Should happen only the first time you launch your application
      // print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (e) {
        // print("error di db helper ${e.toString()}");
      }

      // Copy from asset
      ByteData data = await rootBundle.load("assets/sqlite.db");
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
      //open the newly created db
      db = await openDatabase(path, version: NEW_DB_VERSION);
    } else {
      db = await openDatabase(path);
      // int _dbVersion = await db.getVersion();
      // print("check db version $_dbVersion");
      db.close();
    }
  }

  Future<String> insertFriends({required String id}) async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "sqlite.db");
    var db = await openDatabase(path);
    var select = await db.rawQuery("select * from friends where friend_id = '${id}'");
    if (select.isEmpty) {
      await db.rawInsert('INSERT INTO friends(friend_id) VALUES ("$id")');
    } else {
      await db.rawInsert("DELETE FROM friends where friend_id = '$id'");
    }
    db.close();
    return id;
  }

  Future<List> selectAllFriends() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "sqlite.db");
    var db = await openDatabase(path);
    List listPost = await db.rawQuery('SELECT * FROM friends');
    db.close();
    return listPost;
  }

  Future<String> insertOwner({required Owner owner}) async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "sqlite.db");
    var db = await openDatabase(path);
    var select = await db.rawQuery("select * from owner where owner_id = '${owner.id}'");
    if (select.isEmpty) {
      await db.rawInsert(
          'INSERT INTO owner(owner_id, title, firstname, lastname, picture) VALUES ("${owner.id}", "${owner.title}", "${owner.firstName}", "${owner.lastName}", "${owner.picture}")');
      db.close();
    }
    return owner.id;
  }

  Future<int> insertTag({required List<String> tags}) async {
    String data = '';
    data = tags.join(",");
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "sqlite.db");
    var db = await openDatabase(path);
    int id = await db.rawInsert('INSERT INTO tags(tag_name) VALUES ("$data")');
    db.close();
    return id;
  }

  Future<void> insertPost({
    required PostDetailModel post,
    required int tagId,
    required String ownerId,
  }) async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "sqlite.db");
    var db = await openDatabase(path);
    var select = await db.rawQuery("select * from post where pots_id = '${post.id}'");
    if (select.isEmpty) {
      await db.rawInsert(
          'INSERT INTO post(pots_id, image, likes, tag_id, text, publishDate, owner_id) VALUES ("${post.id}", "${post.image}", "${post.likes}", "$tagId", "${post.text}", "${post.publishDate}", "$ownerId")');
    } else {
      await db.rawDelete("delete from post where pots_id = '${post.id}'");
    }
    db.close();
  }

  Future<List> selectAllPosts() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "sqlite.db");
    var db = await openDatabase(path);
    List listPost = await db.rawQuery(
        'SELECT * FROM post JOIN owner ON owner.owner_id = post.owner_id JOIN tags ON tags.tag_id = post.tag_id');
    db.close();
    return listPost;
  }
}
