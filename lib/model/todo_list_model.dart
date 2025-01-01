class TodoListModel {
  String? title;
  String? description;
  bool? isCompleted;
  String? id;

  TodoListModel({this.title, this.description, this.isCompleted, this.id});

  factory TodoListModel.fromJson(Map<String, dynamic> json) {
    return TodoListModel(
      title: json['title'] as String?,
      description: json['description'] as String?,
      isCompleted:
          json['is_completed'] == null ? false : json['is_completed'] as bool,
      id: json['id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'is_completed': isCompleted ?? false,
      'id': id,
    };
  }
}
