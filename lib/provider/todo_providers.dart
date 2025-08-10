import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo_showcase/model/todo.dart';

//TodoFilter
enum TodoFilters { all, active, compeleted }

//Provider
final todoListProvider =
    StateNotifierProvider<TodoListNotifier, List<Todo>>((ref) {
  return TodoListNotifier();
});

//Filter provider
final todoFilterProvider = StateProvider<TodoFilters>((ref) => TodoFilters.all);

//Provider for computed values (filtered todos)
final filteredTodoProvider = Provider<List<Todo>>((ref) {
  final todos = ref.watch(todoListProvider);
  final filter = ref.watch(todoFilterProvider);

  switch (filter) {
    case TodoFilters.all:
      return todos;
    case TodoFilters.active:
      return todos.where((todo) => !todo.isCompleted).toList();
    case TodoFilters.compeleted:
      return todos.where((todo) => !todo.isCompleted).toList();
  }
});

//Provider for Statistic
final todoStatsProvider = Provider<TodoStats>((ref) {
  final todos = ref.watch(todoListProvider);

  final total = todos.length;
  final completed = todos.where((todo) => todo.isCompleted).length;
  final active = total - completed;

  return TodoStats(
    total: total,
    completed: completed,
    active: active,
  );
});

class TodoStats {
  final int total;
  final int completed;
  final int active;

  TodoStats({
    required this.total,
    required this.completed,
    required this.active,
  });
}

class TodoListNotifier extends StateNotifier<List<Todo>> {
  TodoListNotifier() : super([]);

  //Add method
  void addTodo(String title) {
    if (title.trim().isEmpty) return;

    final newTodo = Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title.trim(),
    );

    state = [...state, newTodo];
  }

  //Toggle method
  void toggleTodo(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          todo.copyWith(isCompleted: !todo.isCompleted)
        else
          todo,
    ];
  }

  //Delete method
  void deleteTodo(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }

  //Clear method when completed
  void clearCompleted() {
    state = state.where((todo) => !todo.isCompleted).toList();
  }

  //Edit method
  void editTodo(String id, String newTitle) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(id: todo.id, title: newTitle, isCompleted: todo.isCompleted)
        else
          todo,
    ];
  }
}
