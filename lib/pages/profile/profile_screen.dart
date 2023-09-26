import 'dart:io';

import 'package:appxcel_academy/auth/login.dart';
import 'package:appxcel_academy/pages/home/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? name = '';
  String? email = '';
  String? phoneNumber = '';
  String? userImage = '';
  String? userNameInput = '';
  File? imageXFile;

  final user = FirebaseAuth.instance.currentUser;

  Future<void> getDataFormDatabase() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
      (snapshot) {
        if (snapshot.exists) {
          setState(() {
            name = snapshot.data()!['name'];
            email = snapshot.data()!['email'];
            phoneNumber = snapshot.data()!['phoneNumber'];
            userImage = snapshot.data()!['userImage'];
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getDataFormDatabase();
  }

  @override
  Widget build(BuildContext context) {
    void showImageDialog() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Please choose an option"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    getFormCamera(context);
                  },
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.camera),
                      ),
                      Text('camera'),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    getFormGallery(context);
                  },
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.image),
                      ),
                      Text('Gallery'),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    Future updateUserName() async {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(
        {
          'name': userNameInput,
        },
      );
    }

    displayTextInputDialog(BuildContext context) async {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Update your UserName here'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  userNameInput = value;
                });
              },
              decoration: const InputDecoration(labelText: 'Type here'),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                  child: const Text('Cancel')),
              ElevatedButton(
                  onPressed: () {
                    updateUserName();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ));
                  },
                  child: const Text('Save'))
            ],
          );
        },
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  showImageDialog();
                },
                child: CircleAvatar(
                  radius: 45,
                  backgroundImage: imageXFile == null
                      ? NetworkImage(userImage!)
                      : Image.file(imageXFile!).image,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("User Name : $name "),
                  IconButton(
                    onPressed: () {
                      displayTextInputDialog(context);
                    },
                    icon: const Icon(Icons.edit_outlined),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Text("Email : $email "),
              const SizedBox(height: 10),
              Text("Phone Number : $phoneNumber "),
              const SizedBox(height: 50),
              OutlinedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ));
                },
                child: const Text('Sign Out'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getFormCamera(cxt) async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    cropImage(pickedFile!.path);
    Navigator.pop(cxt);
  }

  void getFormGallery(cxt) async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    cropImage(pickedFile!.path);
    Navigator.pop(cxt);
  }

  void cropImage(filePath) async {
    CroppedFile? croppedImage = await ImageCropper()
        .cropImage(sourcePath: filePath, maxHeight: 1080, maxWidth: 1080);

    if (croppedImage != null) {
      setState(() {
        imageXFile = File(croppedImage.path);
      });
    }
  }
}
