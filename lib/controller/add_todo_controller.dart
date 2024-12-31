import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddTodoController extends ChangeNotifier {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  void submit() async {
    final title = titleController.text;
    final description = descriptionController.text;
    final body = {
      "title": title,
      "description": description,
      "is_completed": true,
    };
    final response = await http.post(
      Uri.parse(
        "https://virtserver.swaggerhub.com/Kazunori-Kimura/TodoAPI/1/todo",
      ),
      headers: {
        "Content-Type": "application/json",
      },
      body: body,
    );
  }
}
