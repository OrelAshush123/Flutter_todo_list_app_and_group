class Group {
  String name;

  Group({required this.name});

  Map<String, dynamic> toJson() => {'name': name};

  static Group fromJson(Map<String, dynamic> json) => Group(name: json['name']);
}
