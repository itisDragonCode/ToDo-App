import 'package:flutter/material.dart';
import 'package:todo_application/screens/profile/login_page.dart';
import 'package:todo_application/utils/util.dart';
import 'package:todo_application/utils/util_widgets.dart';

class MasterScreenWidget extends StatefulWidget {
  final Widget? child;
  final Widget? floatingActionButton;
  final String? title;
  

  const MasterScreenWidget({super.key, this.child, this.floatingActionButton, this.title});

  @override
  State<MasterScreenWidget> createState() => _MasterScreenWidgetState();
}

class _MasterScreenWidgetState extends State<MasterScreenWidget> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title ?? "",
          style: TextStyle(
            color: Colors.white
          ),
        ),
        centerTitle: true,
         leading: 
          IconButton(
            onPressed: (() {
              if (!ModalRoute.of(context)!.isFirst) {
                Navigator.pop(context,
                    'reload2'); // provjerava da li je prva ruta da se izbjegne prazana rpoute stack
              }
            }),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )
          ),
          actions: [
            IconButton(
              onPressed: (() {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: Text("Log out"),
                        content: Text("Do you want to log out from app?"),
                        actions: [
                          TextButton(
                              onPressed: (() {
                                Navigator.pop(context);
                              }),
                              child: Text("Cancel")),
                          TextButton(
                              onPressed: () async {
                                try {
                                  Autentification.token = '';

                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => const LoginPage()),
                                      (route) => false);
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
              }),
              icon: const Icon(Icons.logout, color: Colors.white,))
          ],
      ),
      floatingActionButton: widget.floatingActionButton,
      body: widget.child!,
    );
  }
  
}
