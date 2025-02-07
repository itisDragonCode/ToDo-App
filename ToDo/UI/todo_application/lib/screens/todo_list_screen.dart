import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/details_pages/todo_detail.dart';
import 'package:todo_application/models/search_result.dart';
import 'package:todo_application/models/to_do_item.dart';
import 'package:todo_application/providers/to_do_item_provider.dart';
import 'package:todo_application/utils/util.dart';
import 'package:todo_application/utils/util_widgets.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key, this.floatingActionButton});

  final Widget? floatingActionButton;

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  late ToDoItemProvider _toDoItemProvider = ToDoItemProvider();
  final TextEditingController _valueController = TextEditingController();

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
      result = await _toDoItemProvider.getPaged(filter: {
        'title': _valueController.text,
        'userId': Autentification.loggedUser?.id,
        'pageSize': 100000
      });
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
    return Column(children: [
      Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: TextField(
                controller: _valueController,
                decoration: InputDecoration(label: Text("Title")),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: (() async {
                  initData();
                }),
                child: Text("Search")),
          )
        ],
      ),
      const SizedBox(
        height: 30,
      ),
      Expanded(
          child: isLoading
              ? SpinKitCircle(color: Colors.lightBlue)
              : ((result == null || result!.items.isEmpty)
                  ? Center(
                      child: Text(
                        'No tasks',
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                      child: ListView.builder(
                        itemCount: result!.items.length,
                        itemBuilder: (context, index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 5,
                            margin: const EdgeInsets.only(bottom: 16),
                            child: ListTile(
                              onTap: () async {
                                var refresh = await Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return TodoDetailsPage(
                                      todoItem: result!.items[index]);
                                }));

                                if (refresh == 'reload') {
                                  initData();
                                }
                              },
                              leading: InkWell(
                                onTap: () async {
                                  try {
                                    await _toDoItemProvider.changeDoneStatus(
                                        result!.items[index].id!);

                                    initData();
                                  } on Exception catch (e) {
                                    alertBox(context, "Error", e.toString());
                                  }
                                },
                                child: Icon(
                                  result!.items[index].isDone!
                                      ? Icons.check_circle
                                      : Icons.circle_outlined,
                                ),
                              ),
                              title: Text(result!.items[index].title!,
                                  style: result!.items[index].isDone!
                                      ? TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough)
                                      : null),
                              subtitle: result!.items[index].isDone!
                                  ? Text('')
                                  : Text(DateFormat('yyyy-MM-dd – kk:mm')
                                      .format(result!.items[index].dueDate!)),
                              trailing: Icon(Icons.star_rate_outlined),
                            ),
                          );
                        },
                      ),
                    ))),
    ]);
  }
}
