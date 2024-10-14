import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_bloc/data/models/isar_todo.dart';
import 'package:todo_bloc/data/repository/isar_todo_repo.dart';
import 'package:todo_bloc/domain/repository/todo_repo.dart';
import 'package:todo_bloc/presentation/todo_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
//get directory path for storing data
  final directory = await getApplicationDocumentsDirectory();
// oepn Isar database
  final isar = await Isar.open([TodoIsarSchema], directory: directory.path);

//initialize the repository with the Isar database
  final todoRepo = IsarTodoRepo(isar);
  runApp(MyApp(todoRepo: todoRepo));
}

class MyApp extends StatelessWidget {
  final TodoRepo todoRepo;
  const MyApp({super.key, required this.todoRepo});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Tasks app with Bloc',
        debugShowCheckedModeBanner: false,
        home: TodoPage(todoRepo: todoRepo));
  }
}
