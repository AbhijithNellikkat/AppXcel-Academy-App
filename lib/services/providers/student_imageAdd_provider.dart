// import 'dart:developer';

// import 'package:appxcel_academy/services/models/student_model.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// import '../functions/firebase_services/student_services.dart';

// class StudentImageuploadProvider extends ChangeNotifier {
//   final FirebaseService firebaseService = FirebaseService();
//   late String imageUrl;

//   Future<String> uploadImage(var imageFile) async {
//     if (imageFile != null) {
//       final ref = FirebaseStorage.instance
//           .ref()
//           .child('studentImages')
//           .child("${DateTime.now()}.jpg");
//       await ref.putFile(imageFile!);
//       imageUrl = await ref.getDownloadURL();

//       return imageUrl;
//     } else {
//       Fluttertoast.showToast(msg: "Please select an Image");
//       return '';
//     }
//   }
// /// C R E A T E    F U N C T I O N
//   Future<void> createStudent(Student student) async {
//     String imageUrl = await uploadImage(student.studentImage);

//     await firebaseService.createStudent(
//       studentImage: student.studentImage,
//       studentName: student.studentName,
//       studentAge: student.studentAge,
//       studentPhoneNumber: student.studentPhoneNumber,
//       studentEmailId: student.studentEmailId,
//       studentPlace: student.studentPlace,
//       createAt: student.createAt,
//       userName: student.userName,
//       userProfilePic: student.userImg,
//       imageUrl: imageUrl,
//     );
//     notifyListeners();
//   }
// }
