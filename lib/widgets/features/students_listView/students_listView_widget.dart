import 'package:appxcel_academy/pages/student_details/student_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListViewWidget extends StatelessWidget {
  const ListViewWidget({
    super.key,
    required this.doId,
    required this.img,
    required this.userImg,
    required this.name,
    required this.date,
    required this.userId,
    required this.studentName,
    required this.studentAge,
    required this.studentPhoneNumber,
    required this.studentEmailId,
    required this.studentPlace,
    required this.studentImage,
  });

  final String doId;
  final String img;
  final String userImg;
  final String name;
  final DateTime date;
  final String userId;
  final String studentName;
  final String studentAge;
  final String studentPhoneNumber;
  final String studentEmailId;
  final String studentPlace;
  final String studentImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        elevation: 16.0,
        shadowColor: Colors.white10,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StudentDetailsScreen(
                        doId: doId,
                        userId: userId,
                        studentName: studentName,
                        studentAge: studentAge,
                        studentPhoneNumber: studentPhoneNumber,
                        studentEmailId: studentEmailId,
                        studentPlace: studentPlace,
                        studentImage: studentImage,
                      ),
                    ));
              },
              child: Image.network(
                img,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 13.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Student Name : $studentName',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17)),
                ),
              ],
            ),
            const SizedBox(height: 23.0),
            Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
              child: Row(
                children: [
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(userImg),
                  ),
                  const SizedBox(width: 3.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Teacher: $name |',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 2.0),
                  Text(
                    DateFormat("dd,MMM,yyyy - hh:m a").format(date).toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 12),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
