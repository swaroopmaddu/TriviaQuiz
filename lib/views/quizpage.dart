import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/Model/apiServiceProvider.dart';
import 'package:quiz/Model/questionbank.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  ApiServiceProvider _apiServiceProvider = ApiServiceProvider();

  int i = 0;
  int max_questions = 0;
  int correct = 0;
  int wrong = 0;
  bool _loading;
  bool isAnswered = false;

  QuestionBank _questions;

  void initState() {
    super.initState();
    // start fetching questions from api
    _loading = true;
    _apiServiceProvider.get_questions().then((value) {
      setState(() {
        _questions = value;
        max_questions = _questions.questions.length;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
          backgroundColor: Colors.white,
          body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 80.0, left: 50, right: 50),
              child: Row(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[500],
                          offset: Offset(4.0, 4.0),
                          blurRadius: 15.0,
                          spreadRadius: 1.0,
                        ),
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(-4.0, -4.0),
                          blurRadius: 15.0,
                          spreadRadius: 1.0,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        correct.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[500],
                          offset: Offset(4.0, 4.0),
                          blurRadius: 15.0,
                          spreadRadius: 1.0,
                        ),
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(-4.0, -4.0),
                          blurRadius: 15.0,
                          spreadRadius: 1.0,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        wrong.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Html(data: _questions.questions[i].question, style: {
                      "html": Style(
                          color: Colors.red,
                          fontSize: FontSize(20),
                          fontWeight: FontWeight.w700),
                    }),
                  ),
                  Wrap(
                    children: _questions.questions[i].options
                        .map(
                          (element) => GestureDetector(
                            onTap: isAnswered
                                ? null
                                : () async {
                                    if (element ==
                                        _questions.questions[i].correctAnswer) {
                                      correct += 1;
                                    } else {
                                      wrong += 1;
                                    }
                                    setState(() {
                                      isAnswered = true;
                                    });
                                    await Future.delayed(
                                        const Duration(seconds: 2));
                                    setState(() {
                                      isAnswered = false;
                                      if (i + 1 < max_questions) {
                                        i += 1;
                                      } else {
                                        _showScoreDialog();
                                      }
                                    });
                                  },
                            child: Container(
                              margin: EdgeInsets.only(left: 10, bottom: 20),
                              width: MediaQuery.of(context).size.width * 0.85,
                              decoration: BoxDecoration(
                                color: isAnswered
                                    ? element ==
                                            _questions
                                                .questions[i].correctAnswer
                                        ? Colors.green
                                        : Colors.red
                                    : Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[500],
                                    offset: Offset(4.0, 4.0),
                                    blurRadius: 15.0,
                                    spreadRadius: 1.0,
                                  ),
                                  BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(-4.0, -4.0),
                                    blurRadius: 15.0,
                                    spreadRadius: 1.0,
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              child: Center(
                                child: Html(data: element, style: {
                                  "html": Style(
                                      color: isAnswered
                                          ? Colors.white
                                          : Colors.blue,
                                      fontSize: FontSize(20),
                                      fontWeight: FontWeight.w600),
                                }),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // user defined function to show score
  void _showScoreDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Center(
              child: Text(
            "Result",
            style: TextStyle(
                color: Colors.blue, fontWeight: FontWeight.w900, fontSize: 28),
          )),
          content: Text(
            "Your score is $correct / $max_questions",
            style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 28,
                fontWeight: FontWeight.w900),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: new Text("Exit"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: new Text("Restart"),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _loading = true;
                });
                _apiServiceProvider.get_questions().then((value) {
                  setState(() {
                    i = 0;
                    correct = 0;
                    wrong = 0;
                    _questions = value;
                    max_questions = _questions.questions.length;
                    _loading = false;
                  });
                });
              },
            ),
          ],
        );
      },
    );
  }
}
