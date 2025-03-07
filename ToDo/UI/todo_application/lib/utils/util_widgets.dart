import 'package:flutter/material.dart';

void alertBox(BuildContext context, String title, String content) {
  showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Ok')),
            ],
          ));
}

void alertBoxMoveBack(BuildContext context, String title, String content) {
  showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                     Navigator.pop(context);
                  },
                  child: const Text('Ok')),
            ],
          ));
}

Row rowMethod(Widget item, [CrossAxisAlignment? crossAxisAlignment]) {
    return Row(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
      children: [item],
    );
  }