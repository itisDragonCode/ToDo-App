import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/models/search_result.dart';
import 'package:todo_application/models/to_do_item.dart';
import 'package:todo_application/providers/to_do_item_provider.dart';
import 'package:todo_application/utils/util_widgets.dart';
import 'package:todo_application/widgets/master_screen.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  late ToDoItemProvider _toDoItemProvider = ToDoItemProvider();
  TextEditingController _valueController = TextEditingController();

  SearchResult<ToDoItem>? result;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _toDoItemProvider = context.read<ToDoItemProvider>();
    initData();
  }

  Future<void> initData() async {
    try {
      result = await _toDoItemProvider.getPaged(
          filter: {'title': _valueController.text, 'pageSize': 100000});
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      alertBox(context, "Error", e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
        title: "To Do items",
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _valueController,
                      decoration: InputDecoration(label: Text("Title")),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: (() async {
                      initData();
                    }),
                    child: Text("Search"))
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
                child: (isLoading || result == null || result!.items.isEmpty)
                    ? Container()
                    : ListView.builder(
                        itemCount: result!.items.length,
                        itemBuilder: (context, index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 5,
                            margin: const EdgeInsets.only(bottom: 16),
                            child: ListTile(
                              title: Text(result!.items[index].title!),
                              subtitle:
                                  Text(result!.items[index].dueDate.toString()),
                            ),
                          );
                        },
                      ))
          ],
        ));
  }
}
