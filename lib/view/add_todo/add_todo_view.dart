import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:tasker/controller/add_todo_controller.dart';
import 'package:tasker/utils/widget/custom_text_field.dart';

import '../../utils/routes/route_navigators.dart';

class AddTodoView extends StatelessWidget {
  const AddTodoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Iconsax.arrow_left_1,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          onPressed: () => RouteNavigators.pop(context),
        ),
        title: Text(
          'Add Todo',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Consumer<AddTodoController>(
        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              spacing: 8.0,
              children: <Widget>[
                CustomTextField(
                  controller: provider.titleController,
                  hintText: "Title",
                  minLine: 1,
                  maxLine: 1,
                ),
                CustomTextField(
                  controller: provider.titleController,
                  hintText: "Description",
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: provider.submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    child: Text(
                      "Submit",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
