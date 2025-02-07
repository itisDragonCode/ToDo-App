import 'package:flutter/material.dart';

class MainMenuPage extends StatelessWidget {
  const MainMenuPage({super.key});

 static const showGrid = true; // Set to false to show ListView


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Row(
                children: [
                   IconButton(onPressed: (){
                      
                  }, icon: Icon(Icons.task)),
                  IconButton(onPressed: (){
        
                  }, icon: Icon(Icons.quiz))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  
}


  