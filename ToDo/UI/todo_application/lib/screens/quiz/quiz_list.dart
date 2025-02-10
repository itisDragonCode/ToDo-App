import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/screens/quiz/start_quiz.dart';

import '../../models/quiz.dart';
import '../../models/search_result.dart';
import '../../providers/quiz_provider.dart';
import '../../utils/util_widgets.dart';

class QuizzesListPage extends StatefulWidget {
  const QuizzesListPage({Key? key}) : super(key: key);

  @override
  State<QuizzesListPage> createState() => _QuizzesListPageState();
}

class _QuizzesListPageState extends State<QuizzesListPage> {
  late QuizProvider _quizProvider = QuizProvider();

  final _titleController = TextEditingController();
  bool isLoading = true;

  SearchResult<Quiz>? result;

  @override
  void initState() {
    super.initState();
    _quizProvider = context.read<QuizProvider>();
    initData();
  }

  Future<void> initData() async {
    try {
      result = await _quizProvider.getActiveQuizzes(
          filter: {'title': _titleController.text, 'pageSize': 100000});
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      alertBox(context, 'Error', e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(43, 0, 43, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: (() {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => const QuizResultListPage()));
                    }),
                    child: Text("Results"))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 10, 50, 50),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _titleController,
                    decoration: InputDecoration(label: Text("Title")),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      try {
                        var data = await _quizProvider.getActiveQuizzes(
                            filter: {
                              "title": _titleController.text,
                              "pageSize": 100000000
                            });

                        if (mounted) {
                          setState(() {
                            result = data;
                          });
                        }
                      } on Exception catch (e) {
                        alertBox(context, "Error", e.toString());
                      }
                    },
                    child: Text("Search")),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          (result == null || result!.items.isEmpty)
              ? Expanded(child: Center(child: Text("No quizzes")))
              : (isLoading
                  ? const SpinKitRing(color: Colors.brown)
                  : Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(50, 20, 50, 50),
                        child: ListView.builder(
                          itemCount: result!.items.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                ListTile(
                                  subtitle: Text(
                                      result!.items[index].description ?? ''),
                                  title: Text("${result!.items[index].title}"),
                                  leading: Text("${result!.items[index].id}"),
                                  onTap: (() async {
                                    var refresh =
                                        await Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => StartQuizPage(
                                          quiz: result!.items[index],
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                                const Divider(
                                  color: Colors.black,
                                  thickness: 0.5,
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ))
        ],
    );
  }
}
