import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/Model/apiServiceProvider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _value = 10;

  int _category = 100;

  int _difficulty = 0;

  TextStyle optionTextStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w700);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[200],
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            Image.asset('assets/images/home.png'),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Text(
              "Trivia Quiz",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 28,
                fontWeight: FontWeight.w900,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 90),
              child: Column(
                children: <Widget>[
                  Row(
                    children: [
                      Text(
                        "Questions  ",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w900),
                      ),
                      DropdownButton(
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 36,
                        underline: SizedBox(),
                        value: _value,
                        items: [
                          DropdownMenuItem(
                              child: Text(
                                "10",
                                style: optionTextStyle,
                              ),
                              value: 10),
                          DropdownMenuItem(
                              child: Text(
                                "15",
                                style: optionTextStyle,
                              ),
                              value: 15),
                          DropdownMenuItem(
                              child: Text(
                                "20",
                                style: optionTextStyle,
                              ),
                              value: 20),
                          DropdownMenuItem(
                              child: Text(
                                "25",
                                style: optionTextStyle,
                              ),
                              value: 25)
                        ],
                        onChanged: (value) {
                          setState(() {
                            _value = value;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        "Category  ",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w900),
                      ),
                      DropdownButton(
                          value: _category,
                          items: [
                            DropdownMenuItem(
                                child: Text(
                                  "Random",
                                  style: optionTextStyle,
                                ),
                                value: 100),
                            DropdownMenuItem(
                                child: Text(
                                  "General Knowledge",
                                  style: optionTextStyle,
                                ),
                                value: 9),
                            DropdownMenuItem(
                                child: Text(
                                  "Books",
                                  style: optionTextStyle,
                                ),
                                value: 10),
                            DropdownMenuItem(
                                child: Text(
                                  "Film",
                                  style: optionTextStyle,
                                ),
                                value: 11),
                            DropdownMenuItem(
                                child: Text(
                                  "Science & Nature",
                                  style: optionTextStyle,
                                ),
                                value: 17),
                            DropdownMenuItem(
                                child: Text(
                                  "Mythology",
                                  style: optionTextStyle,
                                ),
                                value: 20),
                            DropdownMenuItem(
                                child: Text(
                                  "Sports",
                                  style: optionTextStyle,
                                ),
                                value: 21),
                            DropdownMenuItem(
                                child: Text(
                                  "Celebrities",
                                  style: optionTextStyle,
                                ),
                                value: 26)
                          ],
                          onChanged: (value) {
                            setState(() {
                              _category = value;
                            });
                          }),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        "Difficulty  ",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w900),
                      ),
                      DropdownButton(
                          value: _difficulty,
                          items: [
                            DropdownMenuItem(
                                child: Text(
                                  "Easy",
                                  style: optionTextStyle,
                                ),
                                value: 0),
                            DropdownMenuItem(
                                child: Text(
                                  "Medium",
                                  style: optionTextStyle,
                                ),
                                value: 1),
                            DropdownMenuItem(
                                child: Text(
                                  "Hard",
                                  style: optionTextStyle,
                                ),
                                value: 2)
                          ],
                          onChanged: (value) {
                            setState(() {
                              _difficulty = value;
                            });
                          }),
                    ],
                  ),
                  SizedBox(height: 5),
                  SizedBox(height: 10),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => getQuestions(),
                  child: Container(
                    width: 120,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(50),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Start",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w900),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                          size: 32.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  getQuestions() {
    List<String> difficulty = ["easy", "medium", "hard"];
    if (_category != 100) {
      url =
          "https://opentdb.com/api.php?amount=$_value&category=$_category&difficulty=${difficulty[_difficulty]}&type=multiple";
    } else {
      url =
          "https://opentdb.com/api.php?amount=$_value&difficulty=${difficulty[_difficulty]}&type=multiple";
    }
    print(url);
    Navigator.pushNamed(context, '/quiz');
  }
}
