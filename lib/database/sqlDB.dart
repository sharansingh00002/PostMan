import 'package:postman/model/DatabaseModels.dart';
import 'package:postman/resources/values.dart';
import 'package:sqflite/sqflite.dart';

class SqliteDB {
  String databasesPath;
  Database database;

  Future<bool> initDB() async {
    databasesPath = await getDatabasesPath();
    String path = '$databasesPath/apis';
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE Apis (id INTEGER PRIMARY KEY, api TEXT, headers TEXT)');
      },
    );
    return true;
  }

  Future<bool> insertIntoDB({String api, Map<String, String> headers}) async {
    initDB().then((_) async {
      String headersToInsert = '';
      if (headers.length > 0) {
        var keys = headers.keys;
        for (String key in keys) {
          headersToInsert += '$key~*~*~${headers[key]}$headersSplitPattern';
        }
      }
      headersToInsert = (headersToInsert.isNotEmpty)
          ? headersToInsert.substring(
              0, headersToInsert.lastIndexOf(headersSplitPattern))
          : '';

      if (headersToInsert.isNotEmpty &&
          headersToInsert.endsWith(headersSplitPattern)) {
        headersToInsert = headersToInsert.substring(
            0, headersToInsert.lastIndexOf(headersSplitPattern));
      }
      await database.transaction(
        (txn) async => await txn.rawInsert(
            'INSERT INTO Apis(api, headers) VALUES("$api","$headersToInsert")'),
      );
    });
    return true;
  }

  Future<void> deleteFromDB(int index) async {
    await initDB();
    await database.rawDelete('DELETE FROM Apis WHERE id = $index');
    return;
  }

  Future<DBModel> getDataFromDB() async {
    List<List<HeaderValuesModel>> headersCompleteList = List();
    List<String> api = List();
    List<int> idValues = List();
    await initDB();
    List<Map> data = await database.rawQuery('SELECT * FROM Apis');
    for (int i = 0; i < data.length; i++) {
      Map map = data[i]; // SQL query
      api.add(map['api']);
      idValues.add(map['id']);
      List<HeaderValuesModel> headers = List();
      List<String> headersString = ((map['headers']).toString())
          .split(headersSplitPattern); //HEADER in decoded format splitted
      for (String str in headersString) {
        List<String> mapValues = str.split('~*~*~');
        if (mapValues.length > 1) {
          headers.add(HeaderValuesModel(mapValues[0], mapValues[1]));
        }
      }
      headersCompleteList.add(headers);
    }
    return DBModel(
      apis: api,
      headersList: headersCompleteList,
      id: idValues,
    );
  }
}
