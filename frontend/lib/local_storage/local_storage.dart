import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:traditional_financial_asistant/domain/auth/accessToken.dart';
import 'package:traditional_financial_asistant/domain/ekub/ekub_barel.dart';

import '../domain/register/memeber_model.dart';

class DbHelper {
  final int version = 1;
  Database? db;
  Future<Database> openDb() async {
    if (db == null) {
      db = await openDatabase(
        join(await getDatabasesPath(), 'localCache3'),
        onCreate: (database, version) {
          database.execute(
            "CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, fullName TEXT NULL,userName TEXT, email TEXT NULL, password TEXT, balance INTEGER NULL,accessToken TEXT NULL)",
          );

          database.execute(
            "CREATE TABLE ekub(id INTEGER PRIMARY KEY AUTOINCREMENT, description TEXT NULL,name TEXT, amount INTEGER NULL, countdown INTEGER, minMembers INTEGER NULL,duration INTEGER NULL)",
          );
          database.execute(
            "CREATE TABLE member(id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT NULL,won TEXT NULL, paid TEXT NULL,name TEXT NULL)",
          );
        },
        version: version,
      );
    }
    return db!;
  }

  Future<int> insertUser(Map<String, dynamic> accessToken) async {
    Database db = await openDb();

    // Map<String, dynamic> row =
    //     accessToken['user']['accessToken'] = accessToken['accessToken'];
    Map<String, dynamic> row = accessToken['user'];
    row['accessToken'] = accessToken['token'];

    final result = await db.rawQuery('SELECT COUNT(*) FROM users');
    final count = Sqflite.firstIntValue(result);

    if (count == 0) {
      // The table is empty, so add the value
      return await db.insert('users', row);
    } else {
      return await db.update('users', row, where: 'id = ?', whereArgs: [1]);
    }
  }

  Future<List<Map<String, dynamic>>> getUser() async {
    Database db = await openDb();
    return await db.query('users');
  }

  // Future<int> saveAccessToken(AccessToken accessToken) async {
  //   Database db = await openDb();
  //   Map<String, dynamic> row = accessToken.u.toJson()['accessToken'] = accessToken;
  //   print(accessToken);
  //   try {
  //     Map<String, dynamic> queryResult = (await db
  //             .query('users', where: 'userName = ?', whereArgs: [userName]))
  //         .first;
  //     Map<String, dynamic> existingRow = Map.from(queryResult);
  //     if (existingRow.isNotEmpty) {
  //       existingRow['accessToken'] = accessToken.token;
  //     }
  //     print(existingRow);
  //     return await db.update('users', existingRow,
  //         where: 'userName = ?', whereArgs: [userName]);
  //   } catch (e) {
  //     print(e);
  //     return 1;
  //   }
  // }

  getAccessToken() async {
    Database db = await openDb();
    Map<String, dynamic> queryResult = (await db.query('users')).first;
    Map<String, dynamic> existingRow = Map.from(queryResult);

    if (existingRow.isNotEmpty) {
      if (existingRow['accessToken'] != null) {
        return existingRow['accessToken'];
      } else {
        throw Exception('no access token');
      }
    } else {
      throw Exception('no access token');
    }
  }

  Future<int> deleteUser(int id) async {
    Database db = await openDb();
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> insertEkub(List<Ekub> ekubList) async {
    // add ekub to local storage

    Database db = await openDb();
    final batch = db.batch();
    for (var entity in ekubList) {
      batch.insert('ekub', entity.toJson());
    }
    await batch.commit();
    return 1;
  }

  Future<List<Map<String, dynamic>>?>? getEkub() async {
    Database db = await openDb();
    List<Map<String, dynamic>>? lis;

    try {
      List<Map<String, dynamic>> lis = await db.query('ekub');
    } catch (e) {
      print(e);
      throw Exception('no ekub');
    }
    print(lis);
    print('local cache');
    return lis;
  }

  Future<int> updateEkub(Map<String, dynamic> row) async {
    Database db = await openDb();
    int id = row['id'];
    return await db.update('ekub', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> dropDatabase() async {
    // Get the path to the database file
    Database db = await openDb();

    // Delete the database file
    await deleteDatabase(join(await getDatabasesPath(), 'user.db'));
  }

  Future<int> insertMember(List<Member> members, name) async {
    print('insertinig in to members table');
    Database db = await openDb();
    final batch = db.batch();
    for (var entity in members) {
      var tempEntity = entity.toJson();
      print(tempEntity['username']);
      tempEntity['name'] = name;
      batch.insert('member', tempEntity);
    }
    await batch.commit();
    return 1;
  }

  Future<List<Member>?>? getAllMembers(name) async {
    Database db = await openDb();
    print(name);
    final result = await db.query('member', where: 'name = ?', whereArgs: [name]);
    if (result == null) {
      return null;
    }
    final memberList = result.map((e) => Member.fromJson(e)).toList();
    return memberList;
  }
}
