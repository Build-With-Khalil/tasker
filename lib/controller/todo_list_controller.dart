import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/todo_list_model.dart';
import '../utils/routes/route_navigators.dart';

class TodoListController extends ChangeNotifier {
  List<TodoListModel> listData = [];
  List<TodoListModel> get _listData => listData;
  bool isDataLoading = true;
  Future<TodoListModel?> fetch() async {
    final url =
        Uri.parse("https://6774d112922222414819fd5b.mockapi.io/api/todoList");
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List product = json.decode(response.body);
        listData = product.map((json) => TodoListModel.fromJson(json)).toList();
        if (kDebugMode) {
          print(response.body);
        }
        isDataLoading = false;
        notifyListeners();
      } else {
        if (kDebugMode) {
          print("Failed to load details. Status code: ${response.statusCode}");
        }
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print("Failed to load details. Error: $e");
      }
      return null;
    }
  }

  Future<void> edit(String id, TodoListModel updatedTodo) async {
    final url = Uri.parse(
        "https://6774d112922222414819fd5b.mockapi.io/api/todoList/$id");

    try {
      final response = await http.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(updatedTodo.toJson()),
      );

      if (response.statusCode == 200) {
        // Update local list
        final index = listData.indexWhere((todo) => todo.id == id);
        if (index != -1) {
          _listData[index] = updatedTodo;
          notifyListeners(); // Notify UI to refresh
        }

        if (kDebugMode) {
          print("Successfully updated item with ID: $id");
        }
      } else {
        if (kDebugMode) {
          print("Failed to update item. Status code: ${response.statusCode}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Failed to update item. Error: $e");
      }
    }
  }

  Future<bool> delete(String id) async {
    final url = Uri.parse(
        "https://6774d112922222414819fd5b.mockapi.io/api/todoList/$id");

    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        _listData.removeWhere((element) => element.id == id);
        if (kDebugMode) {
          print("Successfully deleted item with ID: $id");
          print("Response: ${response.body}");
        }
        notifyListeners();
        return true;
      } else {
        if (kDebugMode) {
          print("Failed to delete item. Status code: ${response.statusCode}");
        }
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print("Failed to delete item. Error: $e");
      }
      return false;
    }
  }
}

void editTodoDialog(
  BuildContext context,
  TodoListController provider,
  TodoListModel todo,
) {
  final TextEditingController titleController =
      TextEditingController(text: todo.title);
  final TextEditingController descriptionController =
      TextEditingController(text: todo.description);

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Edit Todo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Update the to-do item
              final updatedTodo = TodoListModel(
                id: todo.id,
                title: titleController.text,
                description: descriptionController.text,
                isCompleted: todo.isCompleted,
              );
              provider.edit(
                todo.id.toString(),
                updatedTodo,
              );
              RouteNavigators.pop(context);
            },
            child: Text('Save'),
          ),
        ],
      );
    },
  );
}
