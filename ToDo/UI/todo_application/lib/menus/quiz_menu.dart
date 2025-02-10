import 'package:flutter/material.dart';
import 'package:todo_application/screens/quiz/quiz_list.dart';

class QuizMenuPage extends StatefulWidget {
  const QuizMenuPage({super.key});

  @override
  State<QuizMenuPage> createState() => _QuizMenuPageState();
}

class _QuizMenuPageState extends State<QuizMenuPage> {
 List<String> titles = const ['Quizzes', 'Quiz Results'];

  List<Widget> pages = [QuizzesListPage(), Placeholder()];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          titles[_selectedIndex],
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz_outlined),
            label: 'Quizzes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rate_review),
            label: 'Results',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.lightBlue[800],
        onTap: _onItemTapped,
      ),
    );
  }
}