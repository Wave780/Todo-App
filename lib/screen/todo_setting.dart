import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo_showcase/theme/theme_provider.dart';

class TodoSetting extends ConsumerWidget {
  const TodoSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final themeNotifier = ref.watch(themeProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          //Dark theme
          Card(
            child: SwitchListTile(
              title: const Text('Dark Mode'),
              subtitle: const Text('Use dark mode'),
              value: theme.isDarkMode,
              onChanged: (value) {
                themeNotifier.toggleDarkMode();
              },
            ),
          ),

          const SizedBox(
            height: 16,
          ),

          //Primary Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Primary Color',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                      spacing: 12,
                      children: ['blue', 'red', 'green', 'orange']
                          .map((color) => GestureDetector(
                                onTap: () {
                                  themeNotifier.setPrimaryColor(color);
                                },
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: _getColor(color),
                                      shape: BoxShape.circle,
                                      border: theme.primaryColor == color
                                          ? Border.all(
                                              color: Colors.grey, width: 3)
                                          : null),
                                  child: theme.primaryColor == color
                                      ? const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                        )
                                      : null,
                                ),
                              ))
                          .toList()),

                  const SizedBox(
                    height: 16,
                  ),

                  //Font size Slider
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Font Size: ${theme.fontSize.toInt()}px',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Slider(
                            max: 24.0,
                            min: 12.0,
                            divisions: 12,
                            value: theme.fontSize,
                            onChanged: (value) {
                              themeNotifier.setFontSize(value);
                            },
                          ),
                          Text(
                            'This is how your text will look',
                            style: TextStyle(fontSize: theme.fontSize),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  //Font Family
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Font family',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          DropdownButton<String>(
                            value: theme.fontFamily,
                            isExpanded: true,
                            items: ['Roboto', 'Times', 'Arial']
                                .map((font) => DropdownMenuItem(
                                    value: font,
                                    child: Text(
                                      font,
                                      style: TextStyle(fontFamily: font),
                                    )))
                                .toList(),
                            onChanged: (font) {
                              if (font != null) {
                                themeNotifier.setFontFamily(font);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),

                  //Reset button
                  ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Reset Theme'),
                          content: const Text(
                              'This will reset all theme settings to default. Continue?'),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancel')),
                            ElevatedButton(
                              onPressed: () {
                                themeNotifier.reset();
                                Navigator.pop(context);
                              },
                              child: const Text('Reset'),
                            )
                          ],
                        ),
                      );
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reset to Default'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Color _getColor(String color) {
    switch (color) {
      case 'red':
        return Colors.red;
      case 'green':
        return Colors.green;
      case 'blue':
        return Colors.blue;
      case 'purple':
        return Colors.purple;
      case 'orange':
        return Colors.orange;
      default:
        return Colors.blue;
    }
  }
}
