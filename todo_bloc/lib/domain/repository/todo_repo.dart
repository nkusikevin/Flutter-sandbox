import 'package:todo_bloc/domain/models/todo_model.dart';


/* 
TODO REPOSITORY

Here you define what the app can do

  This is an abstract class that defines the methods that will be implemented in the TodoRepoImpl class.
  The TodoRepoImpl class will be responsible for fetching data from the database and returning it to the UI.
  The TodoRepoImpl class will also be responsible for adding, updating, and deleting data from the database.
*/


abstract class TodoRepo {
  Future<List<Todo>> getTodos();
  Future<void> addTodo(Todo todo);
  Future<void> updateTodo(Todo todo);
  Future<void> deleteTodoById(Todo todo);
}


/*
Notes:
-the repo in the domain layer outlines what operations the app can do , but  doesn't worry about the specific
implementation of those operations . That's the job of the data layer.

- technically, the repo in the domain layer is an abstract class, but it's not necessary to use the abstract keyword
  because all methods in an interface are abstract by default.

- techology agnostic: independent of any technology or framework
*/