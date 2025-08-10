import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo_showcase/provider/todo_providers.dart';

class TodoStat extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(todoStatsProvider);
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _statItem(
            label: 'Total',
            value: stats.total,
            color: Colors.blue,
          ),
          _statItem(
            label: 'Active',
            value: stats.active,
            color: Colors.orange,
          ),
          _statItem(
            label: 'Completed',
            value: stats.completed,
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}

class _statItem extends StatelessWidget {
  final String label;
  final int value;
  final Color color;

  const _statItem(
      {super.key,
      required this.label,
      required this.value,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        )
      ],
    );
  }
}
