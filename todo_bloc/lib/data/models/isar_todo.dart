/*
ISAR TODO MODEL 

Convert todo model into isar todo model hat we can store in out isar database


*/

import 'package:isar/isar.dart';
import 'package:todo_bloc/domain/models/todo_model.dart';

//to genrate isar todo object , run: dart run build_runner build
part 'isar_todo.g.dart';

@Collection()
class TodoIsar {
  Id id = Isar.autoIncrement;
  late String title;
  late bool isCompleted;

  //convert isar object -> pure todo object to use in out app

  Todo toDomain() {
    return Todo(
      id: id,
      title: title,
      isCompleted: isCompleted,
    );
  }

  //convert todo object -> isar object to store in database
  static TodoIsar fromDomain(Todo todo) {
    return TodoIsar()
      ..id = todo.id
      ..title = todo.title
      ..isCompleted = todo.isCompleted;
  }
}
