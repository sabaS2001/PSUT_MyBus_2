import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Messages extends StatefulWidget {
  String email;
  Messages({required this.email});
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
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          primary: true,
          itemBuilder: (_, index) {
            QueryDocumentSnapshot data = snapshot.data!.docs[index];
            Timestamp timestamp = data['time'];
            DateTime dateTime = timestamp.toDate();
            print(dateTime.toString());
            return Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Column(
                crossAxisAlignment: email == data['email']
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 300,
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.blue.shade900,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      title: Text(
                        data['email'],
                        style: const TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'Wellfleet'
                        ),
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 200,
                            child: Text(
                              data['message'],
                              softWrap: true,
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Wellfleet'
                              ),
                            ),
                          ),
                          Text(
                            "${dateTime.hour}:${dateTime.minute}",
                            style: const TextStyle(
                                fontSize: 15,
                                fontFamily: 'Wellfleet'
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}