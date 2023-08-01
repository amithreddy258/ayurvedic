import 'package:flutter/material.dart';

var questionSets = [
  [
    "Question 1 (Set 1)",
    "Question 2 (Set 1)",
    "Question 3 (Set 1)",
  ],
  [
    "Question 4 (Set 2)",
    "Question 5 (Set 2)",
    "Question 6 (Set 2)",
  ],
  [
    "Question 7 (Set 3)",
    "Question 8 (Set 3)",
    "Question 9 (Set 3)",
  ],
];

class questionsPage extends StatefulWidget {
  const questionsPage({Key? key}) : super(key: key);

  @override
  State<questionsPage> createState() => questionsState();
}

class questionsState extends State<questionsPage> {
  var currentSetIndex = 0;
  var questionIndex = 0;
  var selectedAnswers = <String>[];

  void selectAnswer(String answer) {
    setState(() {
      selectedAnswers.add(answer);
      if (questionIndex < questionSets[currentSetIndex].length - 1) {
        questionIndex++;
      }
    });
  }

  void goToNextSet() {
    setState(() {
      currentSetIndex++;
      questionIndex = 0;
    });
  }

  void showThankYouDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Thank You!"),
          content: Text("Thanks for your participation!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  void resetQuestionnaire() {
    setState(() {
      currentSetIndex = 0;
      questionIndex = 0;
      selectedAnswers.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLastQuestion =
        questionIndex == questionSets[currentSetIndex].length - 1;
    final isLastSet = currentSetIndex == questionSets.length - 1;

    return Scaffold(
      appBar: AppBar(title: const Text('Questionnaire')),
      body: Center(
        child: Column(
          children: [
            Text(questionSets[currentSetIndex][questionIndex]),
            SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) {
                final answer = "Option ${index + 1}";
                return ElevatedButton(
                  onPressed: () {
                    selectAnswer(answer);
                  },
                  child: Text(answer),
                );
              },
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (questionIndex > 0)
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        questionIndex--;
                      });
                    },
                    child: Text("Back"),
                  ),
                if (isLastQuestion && !isLastSet)
                  ElevatedButton(
                    onPressed: () {
                      goToNextSet();
                    },
                    child: Text("Next"),
                  ),
                if (isLastQuestion && isLastSet)
                  ElevatedButton(
                    onPressed: () {
                      showThankYouDialog();
                      resetQuestionnaire();
                    },
                    child: Text("Finish"),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
