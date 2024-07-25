class Notes {
  final String id;
  final String title;
  final String description;
  final bool completed;
  final DateTime createdAt;

  Notes({
    required this.id,
    required this.title,
    required this.description,
    required this.completed,
    required this.createdAt,
  });

  factory Notes.fromMap(Map<String, dynamic> map) => Notes(
        id: map["_id"],
        title: map["title"],
        description: map["description"],
        completed: map["completed"],
        createdAt: DateTime.parse(map["createdAt"]),
      );

  factory Notes.fromDB(Map<String, dynamic> map) => Notes(
        id: map["_id"],
        title: map["title"],
        description: map["description"],
        completed: map["completed"] == 1 ? true : false,
        createdAt: DateTime.fromMillisecondsSinceEpoch(map["created_date"]),
      );
}
