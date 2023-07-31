import 'package:flutter/material.dart';
import 'package:ayurvedic/questionspage.dart';

class registerPage extends StatelessWidget {
  const registerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(12),
              child: Container(
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Enter full Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(21))),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Container(
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Age',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(21))),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Container(
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Permanent Adress',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(21))),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Container(
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Phone Number',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(21))),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Container(
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Email Address',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(21))),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Container(
                child: TextField(
                  decoration: InputDecoration(
                      hintText:
                          'Are you willing to participate in the genetic analysis in Ayurgenomic project',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(21))),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return questionsPage();
                    }));
                  },
                  child: Text('Next')),
            ),
          ],
        ),
      ),
    );
  }
}
