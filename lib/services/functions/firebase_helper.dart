// import 'dart:developer';
// import 'dart:io';

// import 'package:appxcel_academy/firebase_options.dart';
// import 'package:cloud_functions/cloud_functions.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// class FirebaseHelper {
//   static Future<void> setupFirebase() async {
//     await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );

//     FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);

//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: false,
//       sound: true,
//     );
//   }

//    static Future<String?> uploadImage(File file) async {
//     final storageRef = FirebaseStorage.instance.ref();
//     Reference? imageRef = storageRef.child('images/token_image.jpg');

//     try {
//       await imageRef.putFile(file);
//       return await imageRef.getDownloadURL();
//     } catch (e) {
//       log(e.toString());
//       return null;
//     }
//   }

//   static Future<void> _onBackgroundMessage(RemoteMessage message) async {
//     await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
//     log('we have received a notification ${message.notification}');
//   }


//    static Future<bool> sendNotification({
//     required String title,
//     required String body,
//     required String token,
//     String? image,
//   }) async {
//     HttpsCallable callable =
//         FirebaseFunctions.instance.httpsCallable('sendNotification');

//     try {
//       final response = await callable.call(<String, dynamic>{
//         'title': title,
//         'body': body,
//         'image': image,
//         'token': token,
//       });

//       log('result is ${response.data ?? 'No data came back'}');

//       if (response.data == null) return false;
//       return true;
//     } catch (e) {
//       log('There was an error $e');
//       return false;
//     }
//   }



// }
