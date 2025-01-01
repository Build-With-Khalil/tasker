import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasker/controller/add_todo_controller.dart';
import 'package:tasker/controller/todo_list_controller.dart';
import 'package:tasker/utils/routes/route_names.dart';
import 'package:tasker/utils/routes/route_pages.dart';
import 'package:tasker/utils/text_theme.dart';
import 'package:tasker/view/todo/todo_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AddTodoController(),
        ),
        ChangeNotifierProvider(
          create: (context) => TodoListController(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: TextThemes.lightTheme,
      darkTheme: TextThemes.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: RouteNames.todoView,
      routes: RoutePages.getRoutes(),
      home: const TodoView(),
    );
  }
}
