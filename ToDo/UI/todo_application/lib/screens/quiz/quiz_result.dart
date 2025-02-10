import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/userquiz_provider.dart';
import '../../utils/util.dart';
import '../../utils/util_widgets.dart';


class QuizResultPage extends StatefulWidget {
  const QuizResultPage({Key? key, this.totalPoint, this.wonPoints, this.quizId})
      : super(key: key);
  final int? totalPoint;
  final int? wonPoints;
  final int? quizId;

  @override
  State<QuizResultPage> createState() => _QuizResultPageState();
}

class _QuizResultPageState extends State<QuizResultPage> {
  late UserQuizProvider _userQuizProvider = UserQuizProvider();

  @override
  void initState() {
    super.initState();
    _userQuizProvider = context.read<UserQuizProvider>();

    addResult();
  }

  Future<void> addResult() async {
    try {
      var result = (widget.wonPoints! / widget.totalPoint! * 100).round();

      Map request = {
        "percentage": result,
        "userId": int.parse(Autentification.tokenDecoded!["Id"]),
        "quizId": widget.quizId
      };
      await _userQuizProvider.insert(request);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(seconds: 2),
          content: Text('Successfully added quiz result')));
    } catch (e) {
      alertBox(context, 'Erro', e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var result = (widget.wonPoints! / widget.totalPoint! * 100).round();
    

    return Scaffold(
      appBar: AppBar(
        title:  Text('Your result'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
               'You have won ${widget.wonPoints}/${widget.totalPoint} which is $result%',
                style: const TextStyle(fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}