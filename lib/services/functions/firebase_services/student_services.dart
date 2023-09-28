
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// final FirebaseAuth auth = FirebaseAuth.instance;

// class FirebaseService {
//   Future<void> createStudent({
//     required String studentImage,
//     required String studentName,
//     required String studentAge,
//     required String studentPhoneNumber,
//     required String studentEmailId,
//     required String studentPlace,
//     required String createAt,
//     required String userName,
//     required String userProfilePic,
//     required String imageUrl,
     
//   }) async {
//     try {
//       FirebaseFirestore.instance
//           .collection('studetDetails')
//           .doc(DateTime.now().toString())
//           .set(
//         {
//           'id': auth.currentUser!.uid,
//           'username': userName,
//           'userEmail': auth.currentUser!.email,
//           'userProfilePic': userProfilePic,
//           'studentImage': imageUrl,
//           'studentName': studentName,
//           'studentAge': studentAge,
//           'studentPhoneNumber': studentPhoneNumber,
//           'studentEmailId': studentEmailId,
//           'studentPlace': studentPlace,
//           'createAt': DateTime.now(),
//         },
//       );
    
//     } catch (e) {
//       Fluttertoast.showToast(msg: "$e");
//     }
//   }
// }
