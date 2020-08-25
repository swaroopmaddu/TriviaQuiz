import 'package:quiz/Model/questionbank.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String url = "";

class ApiServiceProvider {
  Future<QuestionBank> get_questions() async {
    print(url);
    var response = await http.get(url);
    print(response);
    print(url);
    if (response.statusCode == 200) {
      var jsonResponse = response.body;
      QuestionBank questions = QuestionBank.fromJson(json.decode(jsonResponse));
      print(questions);
      return questions;
    } else {
      print("OOps");
    }
  }
}
