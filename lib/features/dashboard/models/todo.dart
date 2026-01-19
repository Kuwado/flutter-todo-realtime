import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  final String? id;
  final String userId;
  final String title;
  final String description;
  final String priority;
  final String progress;
  final List<String> tags;
  final DateTime startDate;
  final DateTime dueDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  Todo({
    this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.priority,
    required this.progress,
    required this.tags,
    required this.startDate,
    required this.dueDate,
    required this.createdAt,
    required this.updatedAt,
  });

  Todo copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    String? priority,
    String? progress,
    List<String>? tags,
    DateTime? startDate,
    DateTime? dueDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Todo(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      progress: progress ?? this.progress,
      tags: tags ?? this.tags,
      startDate: startDate ?? this.startDate,
      dueDate: dueDate ?? this.dueDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Todo.fromFirestore(DocumentSnapshot snapshot) {
    final data = Map<String, dynamic>.from(snapshot.data() as Map);
    return Todo(
      id: snapshot.id,
      userId: data['userId'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      priority: data['priority'] ?? 'low',
      progress: data['progress'] ?? 'waiting',
      tags: List<String>.from(data['tags'] ?? []),
      startDate: (data['startDate'] as Timestamp).toDate(),
      dueDate: (data['dueDate'] as Timestamp).toDate(),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'title': title,
      'description': description,
      'priority': priority,
      'progress': progress,
      'tags': tags,
      'startDate': startDate,
      'dueDate': dueDate,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  static CollectionReference getCollection(FirebaseFirestore firestore) {
    return firestore.collection('todos');
  }
}
