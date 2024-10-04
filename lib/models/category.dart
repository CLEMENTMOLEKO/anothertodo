import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Category extends Equatable {
  final String? id;
  final String name;

  const Category({
    this.id,
    required this.name,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [name];

  static Category empty = const Category(id: null, name: "");

  /// useful getter to check if [Category] is empty
  bool get isEmpty => this == empty;

  /// useful getter to check if [Category] is empty
  bool get isNotEmpty => this != empty;

  Category copyWith({String? name}) {
    return Category(name: name ?? this.name);
  }

  static Category fromJson(Map<String, dynamic> json) {
    return Category(
        id: Uuid.unparse(Uuid.parse(json["id"])), name: json["name"]);
  }

  Map<String, dynamic> toJson() {
    return {"id": id.toString(), "name": name};
  }
}
