import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Messages extends StatefulWidget {
  String email;
  Messages({super.key, required this.email});
  @override
  _MessagesState createState() => _MessagesState(email: email);
}

class _MessagesState extends State<Messages> {
  String email;
  _MessagesState({required this.email});

  final Stream<QuerySnapshot> _messageStream = FirebaseFirestore.instance
      .collection('Messages')
      .orderBy('time')
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _messageStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              color: Colors.blue[900],
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              color: Colors.blue[900],
            ),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (_, index) {
            QueryDocumentSnapshot data = snapshot.data!.docs[index];
            Timestamp timestamp = data['time'];
            DateTime dateTime = timestamp.toDate();
            print(dateTime.toString());
            return Column(
              crossAxisAlignment: email == data['email']
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: ListTile(
                    // tileColor: data['email'] == 'rel12345678@psut.edu.jo' ? Colors.blueGrey.shade50: Colors.blue.shade900,
                    title: Text(
                      data['email'] == 'rel12345678@psut.edu.jo' ? 'Bus Admin': "",
                      style: const TextStyle(
                          fontSize: 13.0,
                          fontFamily: 'Wellfleet'

                      ),
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: email == data['email']
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: data['email'] == 'rel12345678@psut.edu.jo' ? Colors.blueGrey.shade50: Colors.blue.shade900,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: MediaQuery.sizeOf(context).width - MediaQuery.sizeOf(context).width * .45,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              data['message'],
                              style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'Wellfleet',
                                  color: data['email'] == 'rel12345678@psut.edu.jo' ? Colors.black: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "${dateTime.hour}:${dateTime.minute}",
                          style: const TextStyle(
                              fontSize: 10,
                              fontFamily: 'Wellfleet'
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}