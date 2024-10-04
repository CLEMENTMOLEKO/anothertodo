import 'package:anothertodo/common/enum_priority.dart';
import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final Priority priority;
  bool isComplete;
  //final String fileurl;
  //final string categoryId;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.priority,
    this.isComplete = false,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [title, description, startDate, endDate, priority];

  static final empty = Task(
      id: "",
      title: "",
      description: "",
      startDate: DateTime.timestamp(),
      endDate: DateTime.timestamp(),
      priority: Priority.low);

  /// useful getter to check if [Task] is empty
  bool get isEmpty => this == empty;

  /// useful getter to check if [Task] is not empty
  bool get isNotEmpty => this != empty;

  /// Method to togle [Task.isComplete]
  void toggleCompletTask() {
    isComplete = !isComplete;
  }

  Task copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Priority? priority,
    bool? isComplete,
  }) {
    return Task(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        priority: priority ?? this.priority,
        isComplete: isComplete ?? this.isComplete);
  }

  static Task fromJson(Map<String, dynamic> json) {
    return Task(
        id: json["id"] as String,
        title: json["title"] as String,
        description: json["description"] as String,
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        priority: Priority.values.firstWhere((_) => _.name == json["priority"]),
        isComplete: json["isComplete"] as bool);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "startDate": startDate.toString(),
      "endDate": endDate.toString(),
      "priority": priority.name,
      "isComplete": isComplete
    };
  }
}
