import 'base.model.dart';

class Album extends BaseModel {
  final List<Record> records;
  Album({this.records}){
  }
}

class Record extends BaseModel {
  final int userId;
  final int id;
  final String title;
  Record({this.userId, this.id, this.title}){
  }
}


