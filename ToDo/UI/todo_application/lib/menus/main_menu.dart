import 'package:flutter/material.dart';
import 'package:todo_application/menus/quiz_menu.dart';
import 'package:todo_application/menus/todo_menu_page.dart';

class MainMenuPage extends StatelessWidget {
  const MainMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 35, 0, 16),
            child: GridView.count(
              crossAxisCount: 4,
              mainAxisSpacing: 20,
              children: [
                _menuIcon(Icons.task, 'To Do List', ToDoMenuPage()),
                _menuIcon(Icons.quiz, 'Quizzes', QuizMenuPage()),
                _menuIcon(Icons.lock_clock, 'Clock', ToDoMenuPage()),
                _menuIcon(Icons.chat, 'Chat', ToDoMenuPage()),
                _menuIcon(Icons.settings, 'Settings', ToDoMenuPage()),
              ],
            )),
      ),
    );
  }

  Column _menuIcon(IconData icon, String text, Widget destination) {
    return Column(
      children: [
        Builder(builder: (context) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return destination;
              }));
            },
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.teal[100],
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: Offset(0, 4),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 36,
              ),
            ),
          );
        }),
        const SizedBox(height: 15),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
