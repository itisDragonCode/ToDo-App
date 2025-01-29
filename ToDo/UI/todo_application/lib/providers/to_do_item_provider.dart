
import 'package:http/http.dart';
import 'package:todo_application/models/to_do_item.dart';

import '../providers/base_provider.dart';

class ToDoItemProvider extends BaseProvider<ToDoItem> {
  ToDoItemProvider() : super('ToDoItem');
  @override
  ToDoItem fromJson(data) {
    return ToDoItem.fromJson(data);
  }

  Future<void> changeDoneStatus(int todoId) async {
    var url = "${BaseProvider.baseUrl}$endpoint/ChangeDoneStatus/$todoId";

    var uri = Uri.parse(url);

    var headers = createHeaders();

    Response response = await put(uri, headers: headers, body: null);

    if (isValidResponse(response)) {
    } else {
      throw Exception("Unknown error");
    }
  }
}