class Task {
  String title;
  bool isComplete;
  String group;

  Task({required this.title, this.isComplete = false, required this.group});

  Map<String, dynamic> toJson() =>
      {'title': title, 'isComplete': isComplete, 'group': group};

  static Task fromJson(Map<String, dynamic> json) => Task(
        title: json['title'],
        isComplete: json['isComplete'],
        group: json['group'],
      );
}
