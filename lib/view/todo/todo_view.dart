import 'package:flutter/material.dart';

import '../../utils/routes/route_names.dart';
import '../../utils/routes/route_navigators.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Todo List',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: const Center(
        child: Text('Hello, World!'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => RouteNavigators.pushNamed(
          context,
          RouteNames.addTodoView,
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
