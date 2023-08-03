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
  List<String> selectedOptions = [];

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
    if (currentSet < 3) {
      setState(() {
        currentSet++;
        currentQuestion = 0;
      });
      loadQuestions();
    } else {
      // Show a dialog with "Thank you for your participation" message
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
    }
  }

  void onFinishPressed() {
    // saving data into database
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ayurvedic Food Recommendations'),
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
                  //questions
                  SizedBox(height: 20),
                  Text(
                    questionsData[currentQuestion]['question'],
                    style: TextStyle(fontSize: 18),
                  ),
                  // options
                  SizedBox(height: 20),
                  Column(
                    children: List.generate(
                      questionsData[currentQuestion]['options'].length,
                      (index) => RadioListTile(
                        title: Text(
                            questionsData[currentQuestion]['options'][index]),
                        value: questionsData[currentQuestion]['options'][index],
                        groupValue: selectedOptions.length > currentQuestion
                            ? selectedOptions[currentQuestion]
                            : null,
                        onChanged: (value) {
                          setState(() {
                            selectedOptions[currentQuestion] = value;
                          });
                        },
                      ),
                    ),
                  ),
                  // buttons
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (currentQuestion < questionsData.length - 1) {
                        setState(() {
                          currentQuestion++;
                        });
                      } else {
                        onNextPressed();
                      }
                    },
                    child: Text(
                      currentQuestion < questionsData.length - 1
                          ? 'Next'
                          : 'Finish',
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
