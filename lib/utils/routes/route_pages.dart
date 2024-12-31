import 'package:flutter/material.dart';
import 'package:tasker/utils/routes/route_names.dart';

import '../../view/add_todo/add_todo_view.dart';
import '../../view/todo/todo_view.dart';

class RoutePages {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      RouteNames.todoView: (context) => const TodoView(),
      RouteNames.addTodoView: (context) => const AddTodoView(),
    };
  }
}
