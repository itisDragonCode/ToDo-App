// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'to_do_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToDoItem _$ToDoItemFromJson(Map<String, dynamic> json) => ToDoItem(
      (json['id'] as num?)?.toInt(),
      json['title'] as String?,
      json['description'] as String?,
      json['dueDate'] == null
          ? null
          : DateTime.parse(json['dueDate'] as String),
      json['isDone'] as bool?,
    );

Map<String, dynamic> _$ToDoItemToJson(ToDoItem instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'dueDate': instance.dueDate?.toIso8601String(),
      'isDone': instance.isDone,
    };
