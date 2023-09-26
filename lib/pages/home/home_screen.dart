import 'package:appxcel_academy/pages/add_student/add_student_screen.dart';
import 'package:appxcel_academy/pages/profile/profile_screen.dart';
import 'package:appxcel_academy/widgets/features/students_listView/students_listView_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../widgets/features/empty_box/empty_box_view.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const Drawer(
          child: DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [],
            ),
          ),
        ),
        appBar: AppBar(
          title: const Text("Home"),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileScreen(),
                        ));
                  },
                  icon: const Icon(Icons.person)),
            ),
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('studetDetails')
              .orderBy("createAt", descending: true)
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.data.docs != null && snapshot.data.docs.isNotEmpty) {
                return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return ListViewWidget(
                      doId: snapshot.data.docs[index].id,
                      img: snapshot.data.docs[index]['studentImage'],
                      userImg: snapshot.data.docs[index]['userProfilePic'],
                      name: snapshot.data.docs[index]['username'],
                      date: snapshot.data.docs[index]['createAt'].toDate(),
                      userId: snapshot.data.docs[index]['id'],
                      studentName: snapshot.data.docs[index]['studentName'],
                      studentAge: snapshot.data.docs[index]['studentAge'],
                      studentPhoneNumber: snapshot.data.docs[index]
                          ['studentPhoneNumber'],
                      studentEmailId: snapshot.data.docs[index]
                          ['studentEmailId'],
                      studentPlace: snapshot.data.docs[index]['studentPlace'],
                      studentImage: snapshot.data.docs[index]['studentImage'],
                    );
                  },
                );
              }
            } else {
              return const Center(child: Text('There is no tasks'));
            }

            return const Center(child: EmptyBoxView());
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddStudentScreen(),
                ));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
