import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo_showcase/model/todo.dart';
import 'package:riverpod_todo_showcase/provider/todo_providers.dart';

class TodoItem extends ConsumerWidget {
  final Todo todo;
  const TodoItem({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoListProvider);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
          leading: Checkbox(
            value: todo.isCompleted,
            onChanged: (value) {
              ref.read(todoListProvider.notifier).toggleTodo(todo.id);
            },
          ),
          title: Text(
            todo.title,
            style: TextStyle(
              decoration: todo.isCompleted
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
              color: todo.isCompleted ? Colors.grey : null,
            ),
          ),
          trailing: PopupMenuButton<int>(
            onSelected: (item) => handleClick(context, item, todo.id, ref),
            itemBuilder: (context) => [
              const PopupMenuItem<int>(value: 0, child: Text('Edit')),
              const PopupMenuItem<int>(value: 1, child: Text('Delete')),
            ],
          )),
    );
  }

  void handleClick(BuildContext context, int item, String id, WidgetRef ref) {
    switch (item) {
      case 0:
        _showEditDialog(context, id, ref);
        break;
      case 1:
        _showDeleteDialog(context, id, ref);
        break;
    }
  }

//Edit
  void _showEditDialog(BuildContext context, String id, WidgetRef ref) {
    String newTitle = '';
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Edit Todo'),
            content: TextField(
              onChanged: (value) => newTitle = value,
              decoration: const InputDecoration(hintText: "Enter new title"),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel')),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  if (newTitle.trim().isNotEmpty) {
                    ref.read(todoListProvider.notifier).editTodo(id, newTitle);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Save'),
              )
            ],
          );
        });
  }

  //Delete
  void _showDeleteDialog(BuildContext context, String id, WidgetRef ref) {
    String newTitle = '';
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Delete Todo'),
            content: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.warning,
                color: Colors.red,
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'No',
                    style: TextStyle(color: Colors.red),
                  )),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(todoListProvider.notifier).deleteTodo(todo.id);

                  Navigator.pop(context);
                },
                child: const Text(
                  'Yes',
                  style: TextStyle(color: Colors.green),
                ),
              )
            ],
          );
        });
  }
}
