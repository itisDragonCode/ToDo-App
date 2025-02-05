import 'package:json_annotation/json_annotation.dart';
import 'package:todo_application/models/user.dart';

part 'to_do_item.g.dart';

@JsonSerializable()
class ToDoItem {
  int? id;
  String? title;
  String? description;
  DateTime? dueDate;
  bool? isDone;
  int? userId;
  User? user;

  ToDoItem(this.id, this.title, this.description, this.dueDate, this.isDone, this.userId, this.user);

  factory ToDoItem.fromJson(Map<String, dynamic> json) =>
      _$ToDoItemFromJson(json);

  Map<String, dynamic> toJson() => _$ToDoItemToJson(this);
}
