import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tasker/controller/add_todo_controller.dart';
import 'package:tasker/utils/routes/route_names.dart';
import 'package:tasker/utils/routes/route_pages.dart';
import 'package:tasker/view/todo/todo_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AddTodoController(),
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.teal,
        ),
        fontFamily: GoogleFonts.oxygen().fontFamily,
      ),
      themeMode: ThemeMode.system,
      initialRoute: RouteNames.todoView,
      routes: RoutePages.getRoutes(),
      home: const TodoView(),
    );
  }
}
