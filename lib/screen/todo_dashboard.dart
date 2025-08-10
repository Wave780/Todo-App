import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo_showcase/provider/todo_providers.dart';
import 'package:riverpod_todo_showcase/utils/%20widgets/todo_filter.dart';
import 'package:riverpod_todo_showcase/utils/%20widgets/todo_item.dart';

import '../utils/ widgets/todo_stats.dart';

class TodoDashboard extends ConsumerWidget {
  final TextEditingController _controller = TextEditingController();
  TodoDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredTodos = ref.watch(filteredTodoProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod Todo Showcase'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(children: [
        //Statistics section
        TodoStat(),

        //Filter section
        TodoFilter(),

        //Add todos section
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                  child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Enter a new todo...',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (value) => _addTodo(ref, value),
              )),
              const SizedBox(
                width: 8,
              ),
              ElevatedButton(
                onPressed: () => _addTodo(ref, _controller.text),
                child: const Text('Add'),
              )
            ],
          ),
        ),

        //Todos list
        Expanded(
            child: filteredTodos.isEmpty
                ? Center(
                    child: Text(
                      'No todos yet!\nAdd one above to get started.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredTodos.length,
                    itemBuilder: (context, index) {
                      final todo = filteredTodos[index];
                      return TodoItem(todo: todo);
                    },
                  ))
      ]),
    );
  }

  void _addTodo(WidgetRef ref, String title) {
    if (title.trim().isNotEmpty) {
      ref.read(todoListProvider.notifier).addTodo(title);
      _controller.clear();
    }
  }
}
