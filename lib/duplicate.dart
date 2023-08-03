import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class questionsPage extends StatefulWidget {
  @override
  questionsPageState createState() => questionsPageState();
}

class questionsPageState extends State<questionsPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  int currentSet = 1;
  int currentQuestion = 0;
  List<Map<String, dynamic>> questionsData = [];
  List<String?> selectedOptions = List.filled(60, null);
  List<Map<String, dynamic>> responses = [];

  Future<void> loadQuestions() async {
    // Database
    QuerySnapshot snapshot =
        await firestore.collection('questions_set$currentSet').get();
    setState(() {
      questionsData = snapshot.docs
          .map((doc) => {
                'question': doc.get('question'),
                'options': List<String>.from(doc.get('options')),
              })
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().then((_) {
      loadQuestions();
    });
  }

  void onNextPressed() {
    if (currentQuestion < questionsData.length - 1) {
      setState(() {
        currentQuestion++;
      });
    } else {
      if (currentSet < 3) {
        setState(() {
          currentSet++;
          currentQuestion = 0;
        });
        loadQuestions();
      } else {
        // tfinish
        onFinishPressed();
      }
    }
  }

  void onFinishPressed() {
    // currentQuestion = 1;
    // currentSet = 1;
    // thank you pop-up
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thank You!'),
          content: Text('Thank you for participating in the survey.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
    // Saving data into the database
    print(responses);
  }

  void onBackPressed() {
    if (currentQuestion > 0) {
      setState(() {
        currentQuestion--;
      });
    }
  }

  Widget buildButtons() {
    if (currentQuestion == questionsData.length - 1 && currentSet < 3) {
      // next button
      return IconButton(
        onPressed: onNextPressed,
        icon: Icon(Icons.arrow_forward),
        iconSize: 30,
      );
    } else if (currentSet == 3 && currentQuestion == questionsData.length - 1) {
      // finish button
      return IconButton(
        onPressed: onFinishPressed,
        icon: Icon(Icons.check_circle_sharp),
        iconSize: 30,
      );
    }
    //nothing
    return SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Questionnaire'),
      ),
      body: Center(
        child: questionsData.isEmpty
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Set $currentSet - Question ${currentQuestion + 1} of ${questionsData.length}',
                    style: TextStyle(fontSize: 20),
                  ),
                  // Questions
                  SizedBox(height: 20),
                  Text(
                    questionsData[currentQuestion]['question'],
                    style: TextStyle(fontSize: 18),
                  ),
                  // Options
                  SizedBox(height: 20),
                  Column(
                    children: List.generate(
                      questionsData[currentQuestion]['options'].length,
                      (index) => RadioListTile(
                        title: Text(
                            questionsData[currentQuestion]['options'][index]),
                        value: questionsData[currentQuestion]['options'][index],
                        groupValue: selectedOptions[currentQuestion],
                        onChanged: (value) {
                          setState(() {
                            selectedOptions[currentQuestion] = value as String?;
                            responses.add({
                              'setNumber': currentSet,
                              'questionNumber': currentQuestion + 1,
                              'selectedOption': value,
                            });
                            if (currentQuestion != questionsData.length - 1) {
                              onNextPressed();
                            }
                          });
                        },
                      ),
                    ),
                  ),
                  // Buttons
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (currentQuestion > 0) // Show back button conditionally
                        IconButton(
                          onPressed: onBackPressed,
                          icon: Icon(Icons.arrow_back_sharp),
                          iconSize: 30,
                        ),
                      buildButtons(),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
