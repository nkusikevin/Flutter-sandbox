import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/domain/models/todo_model.dart';
import 'package:todo_bloc/presentation/todo_cubit.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  void _showAddTodoDialog(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    final textController = TextEditingController();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add Todo'),
            content: TextField(controller: textController),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  todoCubit.addTodo(textController.text);
                  Navigator.pop(context);
                },
                child: const Text('Add'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks app with Bloc' , style: TextStyle(
          color: Color.fromARGB(255, 255, 255, 255 ), fontSize: 30
        ),),
        backgroundColor:  const Color.fromARGB(255, 16, 16, 16),
      ),
      backgroundColor: const Color.fromARGB(255, 28, 27, 27),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        backgroundColor: Color.fromARGB(255, 0, 255, 55),
        onPressed: () => _showAddTodoDialog(context),
        tooltip: 'Add Todo',
        child: Icon(Icons.add),
      ),
      body: BlocBuilder<TodoCubit, List<Todo>>(builder: (context, todos) {
        return ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final todo = todos[index];
            return ListTile(
              title: Text(todo.title , style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255 ), fontSize: 20, 
                decoration: todo.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                
              ),
              
              ),
              leading: Checkbox(
                value: todo.isCompleted,
                activeColor: Color.fromARGB(255, 0, 255, 55),
                checkColor: Color.fromARGB(255, 0, 0, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onChanged: (_) =>
                    context.read<TodoCubit>().toggleCompletion(todo),
              ),
              trailing: IconButton(
                  onPressed: () => context.read<TodoCubit>().deleteTodo(todo),
                  icon: const Icon(Icons.delete , color: Color.fromARGB(255, 255, 30, 30),)),
            );
          },
        );
      }),
    );
  }
}
