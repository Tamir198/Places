import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;


class SQLHelper{

  static Future<sql.Database> database() async{
    final String _databasesPath = await sql.getDatabasesPath();
    //create new db or open one if exists on the path
    return sql.openDatabase(path.join(_databasesPath, 'places.db'), onCreate: (db, version){
      //run a sql query on the db
      return db.execute('CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
    }, version: 1);
  }

  static Future<void> insertDB(String table,Map<String,Object> data) async {
    //sql.ConflictAlgorithm.replace = for the same entry, override existing data with new one
    final sql.Database db = await SQLHelper.database();
    return db.insert(table, data,conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, Object>>> getData(String table) async{
    final sql.Database db = await SQLHelper.database();
    //get the data with .query
    return db.query(table);
  }
}