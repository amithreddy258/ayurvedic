import 'package:flutter/material.dart';

class QuestionData {
  final String question;
  final List<String> answers;

  QuestionData(this.question, this.answers);
}

var questionSets = [
  [
    QuestionData("Question 1 (Set 1)", ["Answer 1", "Answer 2", "Answer 3"]),
    QuestionData("Question 2 (Set 1)", ["Answer 1", "Answer 2", "Answer 3"]),
    QuestionData("Question 3 (Set 1)", ["Answer 1", "Answer 2", "Answer 3"]),
  ],
  [
    QuestionData("Question 4 (Set 2)", ["Answer 1", "Answer 2", "Answer 3"]),
    QuestionData("Question 5 (Set 2)", ["Answer 1", "Answer 2", "Answer 3"]),
    QuestionData("Question 6 (Set 2)", ["Answer 1", "Answer 2", "Answer 3"]),
  ],
  [
    QuestionData("Question 7 (Set 3)", ["Answer 1", "Answer 2", "Answer 3"]),
    QuestionData("Question 8 (Set 3)", ["Answer 1", "Answer 2", "Answer 3"]),
    QuestionData("Question 9 (Set 3)", ["Answer 1", "Answer 2", "Answer 3"]),
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
  List<String> selectedAnswers = [];

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
      selectedAnswers.clear();
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //question
            Text(
              questionSets[currentSetIndex][questionIndex].question,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            //options
            SizedBox(height: 20),
            Column(
              children: [
                for (var answer
                    in questionSets[currentSetIndex][questionIndex].answers)
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          padding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 24),
                        ),
                        onPressed: () {
                          selectAnswer(answer);
                          // if (isLastQuestion && !isLastSet) {
                          //   goToNextSet();
                          // }
                        },
                        child: Text(answer, style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ),
              ],
            ),

            //down buttons
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //back button
                if (questionIndex > 0)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(16),
                    ),
                    onPressed: () {
                      setState(() {
                        questionIndex--;
                      });
                    },
                    child: Icon(Icons.arrow_back, size: 24),
                  ),

                //next button
                if (isLastQuestion && !isLastSet)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(16),
                    ),
                    onPressed: () {
                      goToNextSet();
                    },
                    child: Icon(Icons.arrow_forward, size: 24),
                  ),

                //Finsih button
                if (isLastQuestion && isLastSet)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(16),
                    ),
                    onPressed: () {
                      showThankYouDialog();
                      resetQuestionnaire();
                    },
                    child: Icon(Icons.check, size: 24),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
