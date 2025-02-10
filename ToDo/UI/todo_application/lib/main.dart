import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/providers/country_provider.dart';
import 'package:todo_application/providers/photo_provider.dart';
import 'package:todo_application/providers/quiz_provider.dart';
import 'package:todo_application/providers/sign_provider.dart';
import 'package:todo_application/providers/to_do_item_provider.dart';
import 'package:todo_application/providers/user_provider.dart';
import 'package:todo_application/providers/userquiz_provider.dart';
import 'package:todo_application/screens/profile/login_page.dart';

import 'providers/answer_provider.dart';
import 'providers/question_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (create) => ToDoItemProvider()),
      ChangeNotifierProvider(create: (create) => CountryProvider()),
      ChangeNotifierProvider(create: (create) => PhotoProvider()),
      ChangeNotifierProvider(create: (create) => UserProvider()),
      ChangeNotifierProvider(create: (create) => SignProvider()),
      ChangeNotifierProvider(create: ((context) => QuizProvider())),
      ChangeNotifierProvider(create: ((context) => QuestionProvider())),
      ChangeNotifierProvider(create: ((context) => AnswerProvider())),
      ChangeNotifierProvider(create: ((context) => UserQuizProvider())),
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
        home: LoginPage());
  }
}
