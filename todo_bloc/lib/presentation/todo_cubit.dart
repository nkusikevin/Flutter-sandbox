/*
ToDO Cubit  - simple state management class that manages the state of the ToDO list.

Each cubit is a list to  todos
*/

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/domain/models/todo_model.dart';
import 'package:todo_bloc/domain/repository/todo_repo.dart';

class TodoCubit extends Cubit<List<Todo>> {
  final TodoRepo _todoRepo;

  TodoCubit(this._todoRepo) : super([]) {
    getTodos();
  }

  void getTodos() async {
    final todos = await _todoRepo.getTodos();
    emit(todos);
  }

  void addTodo(String title) async {
    final todo = Todo(
      id: DateTime.now().millisecondsSinceEpoch,
      title: title,
      isCompleted: false,
    );

    await _todoRepo.addTodo(todo);
    getTodos();
  }

  Future<void> toggleCompletion(Todo todo) async {
    final updatedTodo = todo.toggleCompletion();
    await _todoRepo.updateTodo(updatedTodo);
    getTodos();
  }

  void deleteTodo(Todo todo) async {
    await _todoRepo.deleteTodo(todo);
    getTodos();
  }
}
