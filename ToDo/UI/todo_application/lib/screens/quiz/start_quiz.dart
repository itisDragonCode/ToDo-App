import 'package:flutter/material.dart';

import '../../details_pages/question_detail.dart';
import '../../models/quiz.dart';
import '../../widgets/master_screen.dart';

class StartQuizPage extends StatefulWidget {
  const StartQuizPage({Key? key, this.quiz}) : super(key: key);
  final Quiz? quiz;

  @override
  State<StartQuizPage> createState() => _StartQuizPageState();
}

class _StartQuizPageState extends State<StartQuizPage> {
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: widget.quiz!.title ?? '',
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${"Max points"}: ${widget.quiz?.totalPoints}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20,),
            ElevatedButton(
                onPressed: (() {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: ((context) => QuestionDeatilPage(
                        quiz: widget.quiz,
                      ))));
                }),
                child: Text("Start quiz", style: const TextStyle(fontSize: 18),)),

          ],
        ),
      ),
    );
  }
}