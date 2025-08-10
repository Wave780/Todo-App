import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo_showcase/provider/todo_providers.dart';

class TodoFilter extends ConsumerWidget {
  const TodoFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentFilter = ref.watch(todoFilterProvider);
    final stats = ref.watch(todoStatsProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _FliterChip(
                label: 'All(${stats.total})',
                isSelected: currentFilter == TodoFilters.all,
                onTap: () {
                  ref.read(todoFilterProvider.notifier).state = TodoFilters.all;
                },
              ),
              _FliterChip(
                label: 'Active(${stats.active})',
                isSelected: currentFilter == TodoFilters.active,
                onTap: () {
                  ref.read(todoFilterProvider.notifier).state =
                      TodoFilters.active;
                },
              ),
              _FliterChip(
                label: 'Compeleted(${stats.completed})',
                isSelected: currentFilter == TodoFilters.compeleted,
                onTap: () {
                  ref.read(todoFilterProvider.notifier).state =
                      TodoFilters.compeleted;
                },
              )
            ],
          ))
        ],
      ),
    );
  }
}

class _FliterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FliterChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).primaryColor : Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
