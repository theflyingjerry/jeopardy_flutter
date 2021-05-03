import 'package:http/http.dart';
import 'dart:convert';

class QuestionGetter {
  String question;
  String answer;
  String category;
  int amount;

  Future<void> alexTrebeck() async {
    try {
      Response response =
          await get(Uri.parse('https://jservice.io/api/random'));
      List data = jsonDecode(response.body);
      print(data);
      question = data[0]['question'];
      answer = data[0]['answer'];
      category = data[0]['category']['title'].toUpperCase();
      amount = data[0]['value'];
    } catch (e) {
      print('Caught error: $e');
      answer = 'Error try again';
      question = '';
      amount = 800;
      category = '';
    }
  }

  Future<void> checker() async {
    RegExp exp = RegExp(r'''[^a-zA-Z0-9,.() '"]''');
    if (amount == null) {
      amount = 400;
    }
    bool acceptable = true;
    while (acceptable == true) {
      if (exp.hasMatch(answer) || question == null) {
        await alexTrebeck();
      } else {
        acceptable = false;
      }
    }
  }
}
