import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';

class databaseManager {
  final CollectionReference profileList =
      FirebaseFirestore.instance.collection("profileInfo");
  final CollectionReference questions =
      FirebaseFirestore.instance.collection("questions");

//add data to database
  Future<void> createUserData(String name, int age, String address, int phno,
      String email, bool willingness) async {
    return await profileList.doc(email).set({
      'name': name,
      'age': age,
      'address': address,
      'phno': phno,
      'email': email,
      'willingness': willingness
    });
  }

//get data form database
  Future getQuestions() async {
    List questionList = [];
    try {
      await questions.get().then((QuerySnapshot) {
        QuerySnapshot.docs.forEach((element) {
          questionList.add(element.data);
        });
      });
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
