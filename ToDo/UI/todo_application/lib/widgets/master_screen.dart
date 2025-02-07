import 'package:flutter/material.dart';

class MasterScreenWidget extends StatefulWidget {
  final Widget? child;
  final Widget? floatingActionButton;
  final String? title;

  const MasterScreenWidget(
      {super.key, this.child, this.floatingActionButton, this.title});

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
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: (() {
              if (!ModalRoute.of(context)!.isFirst) {
                Navigator.pop(context,
                    'reload2'); // provjerava da li je prva ruta da se izbjegne prazana rpoute stack
              }
            }),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      floatingActionButton: widget.floatingActionButton,
      body: widget.child!,
    );
  }
}
