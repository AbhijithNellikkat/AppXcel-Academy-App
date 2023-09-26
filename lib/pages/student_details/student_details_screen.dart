import 'package:appxcel_academy/pages/home/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StudentDetailsScreen extends StatelessWidget {
  const StudentDetailsScreen(
      {super.key,
      required this.studentName,
      required this.studentAge,
      required this.studentPhoneNumber,
      required this.studentEmailId,
      required this.studentPlace,
      required this.studentImage,
      required this.userId,
      required this.doId});

  final String studentName;
  final String studentAge;
  final String studentPhoneNumber;
  final String studentEmailId;
  final String studentPlace;
  final String studentImage;
  final String userId;
  final String doId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Student Details'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Card(
            child: ListView(children: [
              Column(
                children: [
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(studentImage),
                  ),
                  const SizedBox(height: 60),
                  Text('Student Name : $studentName'),
                  const SizedBox(height: 10),
                  Text('Student Age : $studentAge'),
                  const SizedBox(height: 10),
                  Text('Student Phone Number : $studentPhoneNumber'),
                  const SizedBox(height: 10),
                  Text('Student Email : $studentEmailId'),
                  const SizedBox(height: 10),
                  Text('Student Place: $studentPlace'),
                  const SizedBox(height: 50),
                  FirebaseAuth.instance.currentUser!.uid == userId
                      ? OutlinedButton(
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection("studetDetails")
                                .doc(doId)
                                .delete()
                                .then((value) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ));
                            });
                          },
                          child: const Text("Delete"))
                      : Container(),
                  // FirebaseAuth.instance.currentUser!.uid == userId
                  //     ? OutlinedButton(
                  //         onPressed: () {
                  //           Navigator.pushReplacement(
                  //               context,
                  //               MaterialPageRoute(
                  //                 builder: (context) => UpdateStudentScreen(),
                  //               ));
                  //         },
                  //         child: const Text("Update"))
                  //     : Container(),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
