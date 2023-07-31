import 'package:flutter/material.dart';

var questions = ["question1", "question2", "question3"];

class questionsPage extends StatefulWidget {
  const questionsPage({super.key});

  @override
  State<questionsPage> createState() => questionsState();
}

class questionsState extends State<questionsPage> {
  var questionIndex = 0;

  void selectAnswer() {
    setState(() {
      if (questionIndex < questions.length) {
        questionIndex = questionIndex + 1;
      } else {
        questionIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: const Text('Register page')),
            body: Column(
              children: [
                Text(questions[questionIndex]),
                ElevatedButton(onPressed: selectAnswer, child: Text("answer")),
                ElevatedButton(onPressed: selectAnswer, child: Text("answer")),
                ElevatedButton(onPressed: selectAnswer, child: Text("answer")),
                ElevatedButton(onPressed: selectAnswer, child: Text("answer"))
              ],
            )));
  }
}
