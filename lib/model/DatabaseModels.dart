class HeaderValuesModel {
  String key;
  String value;
  HeaderValuesModel(this.key, this.value);
}

class DBModel {
  List<List<HeaderValuesModel>> headersList;
  List<String> apis;
  List<int> id;
  DBModel({this.headersList, this.apis, this.id});
}
