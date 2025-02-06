import 'package:flutter/material.dart';
import 'package:todo_application/details_pages/todo_detail.dart';
import 'package:todo_application/screens/profile/login_page.dart';
import 'package:todo_application/screens/profile/profile_page.dart';
import 'package:todo_application/screens/todo_list_screen.dart';
import 'package:todo_application/utils/util.dart';
import 'package:todo_application/utils/util_widgets.dart';

class ToDoMenuPage extends StatefulWidget {
  const ToDoMenuPage({super.key});

  @override
  State<ToDoMenuPage> createState() => _ToDoMenuPageState();
}

class _ToDoMenuPageState extends State<ToDoMenuPage> {
  List<String> titles = const ['To Do items', 'Notifications', 'Profile'];

  List<Widget> pages = [TodoListScreen(), Placeholder(), ProfilePage()];

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
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.lightBlue[800],
        onTap: _onItemTapped,
      ),
      floatingActionButton: _selectedIndex != 0 ? null : FloatingActionButton(
          onPressed: ()  {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) {
              return TodoDetailsPage();
            }));
          },
          backgroundColor: Colors.lightBlue,
          tooltip: 'Add To Do Item',
          child: const Icon(Icons.add, color: Colors.white),
        ),
    );
  }
}
