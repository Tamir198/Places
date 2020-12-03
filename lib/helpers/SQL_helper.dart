import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;


class SQLHelper{

  static Future<sql.Database> database() async{
    final String _databasesPath = await sql.getDatabasesPath();
    //create new db or open one if exists on the path
    return sql.openDatabase(path.join(_databasesPath, 'places.db'), onCreate: (db, version){
      //run a sql query on the db
      return db.execute('CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, loc_lat REAL, loc_lng REAL, address TEXT)');
    }, version: 1);
  }

  static Future<void> insertDB(String table,Map<String,Object> data) async {
    final sql.Database db = await SQLHelper.database();
    //For the same entry in the db existing data will get overridden with new one
    return db.insert(table, data,conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, Object>>> getTableData(String table) async{
    final sql.Database db = await SQLHelper.database();
    //get the data with .query
    return db.query(table);
  }
}