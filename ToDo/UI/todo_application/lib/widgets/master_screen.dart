import 'package:flutter/material.dart';

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
        centerTitle: false,
      ),
      floatingActionButton: widget.floatingActionButton,
      body: widget.child!,
    );
  }
  
}
