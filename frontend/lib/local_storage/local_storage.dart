import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:traditional_financial_asistant/domain/auth/accessToken.dart';
import 'package:traditional_financial_asistant/domain/edir/Edir.dart';
import 'package:traditional_financial_asistant/domain/ekub/ekub_barel.dart';
import 'package:traditional_financial_asistant/domain/register/edirmember.dart';

import '../domain/register/memeber_model.dart';

class DbHelper {
  final int version = 1;
  Database? db;
  Future<Database> openDb() async {
    // if (db == null) {
      db = await openDatabase(
        join(await getDatabasesPath(), 'localCache7'),
        onCreate: (database, version) {
          database.execute(
            "CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, fullName TEXT NULL,userName TEXT, email TEXT NULL, password TEXT, balance INTEGER NULL,accessToken TEXT NULL)",
          );

          database.execute(
            "CREATE TABLE ekub(id INTEGER PRIMARY KEY AUTOINCREMENT, description TEXT NULL,name TEXT, amount INTEGER NULL, countdown INTEGER, minMembers INTEGER NULL,duration INTEGER NULL,creator INTEGER NULL,canPay INTEGER NULL)",
          );
          database.execute(
            "CREATE TABLE member(id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT NULL,won TEXT NULL, paid TEXT NULL,name TEXT NULL)",
          );
          database.execute(
            "CREATE TABLE edir(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, amount INTEGER NULL, countdown INTEGER, duration INTEGER NULL)",
          );
          database.execute(
            "CREATE TABLE edirmember(id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT NULL,penality TEXT NULL, paid TEXT NULL, name TEXT NULL)",
          );
        },
        version: version,
      );
   
    return db!;
  }

  Future<int> insertUser(Map<String, dynamic> accessToken) async {
    print("accessToken");
    try {
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
    } catch (e) {
      print(e);
      throw Exception('insert not working');
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
      entity.toJson()['creator'] = entity.toJson()['creator'] ? 1 : 0;
      entity.toJson()['canPay'] = entity.toJson()['canPay'] ? 1 : 0;
      batch.insert('ekub', entity.toJson());
    }
    await batch.commit();
    return 1;
  }

  Future<int> insertEdir(List<Edir> edirList) async {
    // add edir to local storage

    Database db = await openDb();
    final batch = db.batch();
    for (var entity in edirList) {
      batch.insert('edir', entity.toJson());
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

    // chanage creator and canpay to bool

    if (lis == null) {
      return null;
    }
    for (var entity in lis) {
      print(entity);
      entity['creator'] = entity['creator'] == 1 ? true : false;
      entity['canPay'] = entity['canPay'] == 1 ? true : false;
      print(entity);
    }
    print('local cache');
    return lis;
  }

  Future<List<Map<String, dynamic>>> getEdir() async {
    Database db = await openDb();
    return await db.query('edir');
  }

  Future<int> updateEkub(Map<String, dynamic> row) async {
    Database db = await openDb();
    row['creator'] = row['creator'] ? 1 : 0;
    row['canPay'] = row['canPay'] ? 1 : 0;
    int id = row['id'];
    return await db.update('ekub', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateEkubList(List<Ekub> rows) async {
    Database db = await openDb();

    Batch batch = db.batch();

    for (var row in rows) {
      Map<String, dynamic> mapObj = row.toJson();
      print(mapObj);
      mapObj['creator'] = mapObj['creator'] ? 1 : 0;
      mapObj['canPay'] = mapObj['canPay'] ? 1 : 0;
      print(mapObj);
      int name = mapObj['name'];

      try {
        batch.update('ekub', mapObj, where: 'name = ?', whereArgs: [name]);
      } catch (e) {
        print(e);
      }
    }

    await batch.commit();
  }

  Future<int> updateEdir(Map<String, dynamic> row) async {
    Database db = await openDb();
    int id = row['id'];
    return await db.update('edir', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> dropDatabase() async {
    // Get the path to the database file
    print('get in to drop');
    Database db = await openDb();

    // Delete the database file
    await deleteDatabase(join(await getDatabasesPath(), 'localCache6'));

    print('gets out of drop');
    db = await openDb();

    // List<Map<String, dynamic>> tables = await db.rawQuery(
    //   "SELECT name FROM sqlite_master WHERE type='table'",
    // );

    // // Iterate through each table and drop it
    // tables.forEach((table) async {
    //   String tableName = table['name'];
    //   if (tableName != 'android_metadata' && tableName != 'sqlite_sequence') {
    //     await db.execute("DROP TABLE IF EXISTS $tableName");
    //   }
    // });
    
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
    final result =
        await db.query('member', where: 'name = ?', whereArgs: [name]);
    if (result == null) {
      return null;
    }
    final memberList = result.map((e) => Member.fromJson(e)).toList();
    return memberList;
  }

  Future<List<EdirMember>?>? getAllEdirMembers(name) async {
    Database db = await openDb();
    print(name);

    final result =
        await db.query('edirmember', where: 'name = ?', whereArgs: [name]);
    print(result);
    if (result == null) {
      return null;
    }
    final memberList = result.map((e) => EdirMember.fromJson(e)).toList();

    return memberList;
  }

  Future<int> insertEdirMember(List<EdirMember> members, name) async {
    print('insertinig in to eders members table');
    Database db = await openDb();
    final batch = db.batch();

    for (var entity in members) {
      var tempEntity = entity.toJson();
      print(tempEntity['username']);
      // print("nameeeeeeeeeeeeeeeeeeeeeeeeee");
      tempEntity['name'] = name;
      batch.insert('edirmember', tempEntity);
    }

    print("its working");
    await batch.commit();
    return 1;
  }
}
