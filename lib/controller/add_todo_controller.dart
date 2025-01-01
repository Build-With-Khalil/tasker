import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddTodoController extends ChangeNotifier {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  Future<void> submit(BuildContext context) async {
    final title = titleController.text;
    final description = descriptionController.text;
    final body = {
      "title": title,
      "description": description,
    };
    final response = await http.post(
      Uri.parse(
        "https://6774d112922222414819fd5b.mockapi.io/api/todoList",
      ),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );
    if (response.statusCode == 201) {
      if (kDebugMode) {
        print("Todo Added");
      }
      snackBar("Todo Created", context);
    } else {
      if (kDebugMode) {
        print("Failed to add todo: ${response.body}");
      }
    }
    titleController.clear();
    descriptionController.clear();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
  }

  void snackBar(String message, BuildContext context) {
    final snackBarr = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBarr);
  }
}
