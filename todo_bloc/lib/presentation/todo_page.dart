/*

TODO Page : responsible for providing the TodoCubit to the TodoView

- use the BlocProvider widget to provide the TodoCubit to the TodoView

*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/domain/repository/todo_repo.dart';
import 'package:todo_bloc/presentation/todo_cubit.dart';
import 'package:todo_bloc/presentation/todo_view.dart';

class TodoPage extends StatelessWidget {
  final TodoRepo todoRepo;
  const TodoPage({super.key, required this.todoRepo});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => TodoCubit(todoRepo), child: TodoView());
  }
}
