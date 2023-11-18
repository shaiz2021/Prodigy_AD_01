import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_notifier.dart';
import 'todo_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<void> _initializeApp() async {
    // Place your app initialization logic here, e.g., fetching data, initializing resources, etc.
    await Future.delayed(
        const Duration(seconds: 2)); // Simulate some loading time
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ChangeNotifierProvider<ThemeNotifier>(
            create: (_) => ThemeNotifier(),
            child: Builder(
              builder: (context) {
                final themeNotifier = Provider.of<ThemeNotifier>(context);
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Todo App',
                  // ThemeData.dark() theme if themeNotifier.isDark is true else ThemeData.light() with custom appbar color
                  theme: themeNotifier.isDark
                      ? ThemeData.dark()
                      : ThemeData(
                          scaffoldBackgroundColor: Colors.blueGrey,
                          appBarTheme: const AppBarTheme(
                            // purple color with a bit of transparency
                            color: Colors.blueGrey,
                          ),
                        ),
                  home: const TodoListScreen(),
                );
              },
            ),
          );
        } else {
          return const MaterialApp(
            home: Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
