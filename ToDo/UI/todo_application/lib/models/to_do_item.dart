import 'package:json_annotation/json_annotation.dart';

part 'to_do_item.g.dart';

@JsonSerializable()
class ToDoItem {
  int? id;
  String? title;
  String? description;
  DateTime? dueDate;
  bool? isDone;

  ToDoItem(this.id, this.title, this.description, this.dueDate, this.isDone);

  factory ToDoItem.fromJson(Map<String, dynamic> json) =>
      _$ToDoItemFromJson(json);

  Map<String, dynamic> toJson() => _$ToDoItemToJson(this);
}