import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/providers/to_do_item_provider.dart';
import 'package:todo_application/screens/todo_list_screen.dart';

// void main() {
//   runApp(const MyApp());
// }

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (create)=> ToDoItemProvider())
  ],
  child: const MyApp(),
  ));
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: TodoListScreen()
    );
  }
}
