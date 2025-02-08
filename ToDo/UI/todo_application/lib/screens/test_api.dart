import 'package:flutter/material.dart';
import 'package:http/http.dart';

class TesApiPage extends StatefulWidget {
  const TesApiPage({super.key});

  @override
  State<TesApiPage> createState() => _TesApiPageState();
}

class _TesApiPageState extends State<TesApiPage> {
  String _result = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 400,
          width: 250,
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () async {
                    var uri =
                        Uri.parse("http://192.168.0.28:5002/api/ToDoItem/GetPaged");
          
                    try {
                      Response response = await get(uri,
                          headers: {"Content-Type": "application/json"});
                      _result = "Success: ${response.statusCode}";
                    } catch (e) {
                      _result = "Error: ${e.toString()}";
                    }
                  },
                  child: Text('Call api')),
              Text(_result)
            ],
          ),
        ),
      ),
    );
  }
}
