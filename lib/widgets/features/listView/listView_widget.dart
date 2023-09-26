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
  });

  final String doId;
  final String img;
  final String userImg;
  final String name;
  final DateTime date;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Card(
        elevation: 16.0,
        shadowColor: Colors.white10,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Image.network(
                    img,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10.0),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundImage: NetworkImage(userImg),
                      ),
                      const SizedBox(width: 10.0),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Teacher: $name |',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 2.0),
                      Text(
                        DateFormat("dd,MMM,yyyy - hh:m a")
                            .format(date)
                            .toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
