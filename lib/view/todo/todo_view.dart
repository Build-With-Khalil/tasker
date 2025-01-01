import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasker/controller/todo_list_controller.dart';
import 'package:tasker/model/todo_list_model.dart';
import 'package:tasker/view/todo/components/todo_widget.dart';

import '../../utils/routes/route_names.dart';
import '../../utils/routes/route_navigators.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context) {
    final todoListController =
        Provider.of<TodoListController>(context, listen: false);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Todo List',
          style: Theme.of(context).textTheme.headlineSmall!.apply(
                color: Colors.white,
              ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<TodoListModel?>(
        future: todoListController.fetch(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error:${snapshot.error}'),
            );
          } else if (snapshot.hasData || snapshot.data != null) {
            return const Center(
              child: Text("No data Found"),
            );
          } else {
            return Consumer<TodoListController>(
              builder: (context, provider, child) {
                return Visibility(
                  visible: provider.isDataLoading,
                  replacement: RefreshIndicator(
                    onRefresh: () => provider.fetch(),
                    child: ListView.builder(
                      itemCount: provider.listData.length,
                      itemBuilder: (context, index) {
                        final product = provider.listData[index];
                        return TodoWidget(
                          id: "${index + 1}",
                          title: product.title.toString(),
                          description: product.description.toString(),
                          onDeletePressed: () => provider.delete(
                            product.id.toString(),
                          ),
                          onEditPressed: () => editTodoDialog(
                            context,
                            provider,
                            product,
                          ),
                        );
                      },
                    ),
                  ),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => RouteNavigators.pushNamed(
          context,
          RouteNames.addTodoView,
        ),
        child: Icon(
          Icons.add,
          color: Theme.of(context).canvasColor,
        ),
      ),
    );
  }
}
