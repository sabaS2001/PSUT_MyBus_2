import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:psut_my_bus/PsutStudentApp/psBottomNavBar.dart';

class PSNotification extends StatefulWidget {
  const PSNotification({super.key});

  @override
  State<PSNotification> createState() => _PSNotificationState();
}

class _PSNotificationState extends State<PSNotification> {
  Stream<QuerySnapshot<Object?>> notify = FirebaseFirestore.instance
      .collection('Notifications')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.all(11.0),
          child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PSNavBar()),
              );
            },
            icon: const Icon(
              Icons.arrow_circle_left_outlined,
              size: 40.0,
            ),
            color: Colors.blue[900],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Notitfications',
                  style: TextStyle(
                    fontFamily: 'Wellfleet',
                    fontSize: 30.0,
                  ),
                ),
              ],
            ),
            Container(
              width: MediaQuery.sizeOf(context).width * .90,
              height: MediaQuery.sizeOf(context).height,
              margin: const EdgeInsets.all(5),
              child: StreamBuilder<QuerySnapshot>(
                  stream: notify,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                        return Column(
                          children: snapshot.data!.docs.map((doc) {
                            Map<String, dynamic> data =
                                doc.data() as Map<String, dynamic>;
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Icon(
                                  Icons.wrong_location_sharp,
                                  color: Colors.red,
                                  size: 40,
                                ),
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width * .50,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Emergency Notification',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontFamily: 'Wellfleet'),
                                      ),
                                      Text(
                                        data['message'],
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontFamily: 'Wellfleet',
                                            color: Colors.grey.shade600),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  child: Text(
                                    DateFormat.yMd()
                                        .format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                data['time']
                                                    .millisecondsSinceEpoch))
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontFamily: 'Wellfleet',
                                        color: Colors.grey.shade600),
                                  ),
                                )
                              ],
                            );
                          }).toList(),
                        );
                      }
                      return Container(
                        margin: const EdgeInsets.fromLTRB(20,90,20,20),
                        height: MediaQuery.sizeOf(context).height - MediaQuery.sizeOf(context).height*.20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.mark_unread_chat_alt_sharp,
                              color: Colors.blue.shade900,
                            size: 70,),
                            const Text('No Notifcations',
                              style: TextStyle(
                                  fontFamily: 'WellFleet',
                                fontSize: 16.0
                              ),),
                            const Text('We’ll let you know when there will be something to update you.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Wellfleet',
                                  fontSize: 16.0
                              ),)
                          ],
                        ),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Center(
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: CircularProgressIndicator(
                            strokeWidth: 4.0,
                            color: Colors.blue[900],
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
