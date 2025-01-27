
import 'package:todo_application/models/to_do_item.dart';

import '../providers/base_provider.dart';

class ToDoItemProvider extends BaseProvider<ToDoItem> {
  ToDoItemProvider() : super('ToDoItem');
  @override
  ToDoItem fromJson(data) {
    return ToDoItem.fromJson(data);
  }
}