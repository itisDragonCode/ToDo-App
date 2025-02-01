import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:todo_application/models/to_do_item.dart';
import 'package:todo_application/providers/to_do_item_provider.dart';
import 'package:todo_application/utils/util.dart';
import 'package:todo_application/utils/util_widgets.dart';

class TodoDetailsPage extends StatefulWidget {
  const TodoDetailsPage({super.key, this.todoItem});

  final ToDoItem? todoItem;

  @override
  State<TodoDetailsPage> createState() => _TodoDetailsPageState();
}

class _TodoDetailsPageState extends State<TodoDetailsPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  late ToDoItemProvider _toDoItemProvider = ToDoItemProvider();
  Map<String, dynamic> _initialValue = {};

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'title': widget.todoItem?.title,
      'dueDate': widget.todoItem?.dueDate,
      'isDone': widget.todoItem?.isDone
    };

    initForm();
  }

  Future<void> initForm() async {
    try {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    } on Exception catch (e) {
      alertBox(context, "Error", e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context); // Pop the current screen and go back
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.todoItem != null ? "Edit Task" : "Add Task", 
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: FormBuilder(
            initialValue: _initialValue,
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(45, 40, 45, 20),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      // const SizedBox(
                      //   height: 60,
                      // ),
                      rowMethod(_textField('title', "Title")),
                      const SizedBox(
                        height: 25,
                      ),
                      rowMethod(
                        Expanded(
                            child: FormBuilderDateTimePicker(
                          name: 'dueDate',
                          validator: (value) {
                            if (value == null) {
                              return "Date is mandatory";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(label: Text("Due date")),
                        )),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Visibility(
                            visible: widget.todoItem != null,
                            child: IconButton(onPressed: (){
                                 showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                    title: Text(
                                                        "Deleting Task"),
                                                    content: Text(
                                                       "Are you sure that you want to delete this task?"),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: (() {
                                                            Navigator.pop(context);
                                                          }),
                                                          child: Text(
                                                              "Cancel")),
                                                      TextButton(
                                                          onPressed: () async {
                                                            try {
                                                              await _toDoItemProvider
                                                                  .remove(widget
                                                                          .todoItem?.id ??
                                                                      0);
                                            
                                                              ScaffoldMessenger.of(
                                                                      context)
                                                                  .showSnackBar(SnackBar(
                                                                      content: Text("Task successfully deleted"
                                                                         )));
                                                              Navigator.pop(context);
                                                              Navigator.pop(
                                                                  context, 'reload');
                                                            } catch (e) {
                                                              alertBoxMoveBack(
                                                                  context,
                                                                  "Error",
                                                                  e.toString());
                                                            }
                                                          },
                                                          child: const Text('Ok')),
                                                    ],
                                                  ));
                            }, icon: Icon(Icons.delete), color: Colors.red,),
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightBlue,
                              ),
                              onPressed: () async {
                                try {
                                  _formKey.currentState?.save();
                                  if (_formKey.currentState!.validate()) {
                                    if (widget.todoItem != null) {
                                      Map<String, dynamic> request =
                                          Map.of(_formKey.currentState!.value);

                                      request['id'] = widget.todoItem?.id;

                                      request['dueDate'] = dateEncode(_formKey
                                          .currentState?.value['dueDate']);

                                      request['isDone'] = false;

                                      await _toDoItemProvider.update(request);

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Task successfully modified")));

                                      Navigator.pop(context, 'reload');
                                    } else {
                                      Map<String, dynamic> request =
                                          Map.of(_formKey.currentState!.value);

                                      request['dueDate'] = dateEncode(_formKey
                                          .currentState?.value['dueDate']);

                                      request['isDone'] = false;

                                      await _toDoItemProvider.insert(request);

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Task successfully added")));

                                      Navigator.pop(context, 'reload');
                                    }
                                  } else {}
                                } catch (e) {
                                  alertBox(context, "Error", e.toString());
                                }
                              },
                              child: Text(
                                "Save",
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Expanded _textField(String name, String label) {
  return Expanded(
    child: FormBuilderTextField(
      name: name,
      validator: ((value) {
        if (value == null || value.isEmpty) {
          return "Value is mandatory";
        } else {
          return null;
        }
      }),
      decoration: InputDecoration(
        label: Text(label),
      ),
    ),
  );
}
