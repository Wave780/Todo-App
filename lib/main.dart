import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo_showcase/screen/todo_dashboard.dart';
import 'package:riverpod_todo_showcase/theme/theme_provider.dart';
import 'package:riverpod_todo_showcase/utils/preference_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PreferenceService.init();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTheme = ref.watch(themeProvider);
    return MaterialApp(
      title: 'Riverpod Todo Showcase',
      theme: appTheme.toThemeData(),
      home: TodoDashboard(),
    );
  }
}
