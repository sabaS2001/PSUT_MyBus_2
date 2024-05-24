import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'psBottomNavBar.dart';


class PSBusSchedule extends StatefulWidget {
  const PSBusSchedule({super.key});

  @override
  State<PSBusSchedule> createState() => _PSBusScheduleState();
}

class _PSBusScheduleState extends State<PSBusSchedule> {
  String dateFormat = DateFormat('EEEE, MMM d, yyyy').format(DateTime.now());
  late CollectionReference<Object?>? busScheduleCollection =  FirebaseFirestore.instance.collection('markers').doc('Tabarbour').collection('Routes'); // return null if the document does not exist;
  String busLine = '';


  Future<void> _initBusScheduleCollection() async {
    busScheduleCollection = await readData();
    setState(() {});
  }

  Future<CollectionReference<Object?>?> readData() async {
    User? user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('students').doc(user?.uid).get();
    if (documentSnapshot.exists) {
      busLine = documentSnapshot.get('busLine');
      print(busLine);
      if (busLine == 'Marj Al Hammam') {
        return FirebaseFirestore.instance.collection('markers').doc('Marj Al Hammam').collection('Routes2');
      } else if (busLine == 'Madinah ') {
        return FirebaseFirestore.instance.collection('markers').doc('Madinah ').collection('Routes');
      }
    } else {
      print('Document does not exist');
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _initBusScheduleCollection();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Center(
          child: Container(
            margin: const EdgeInsets.fromLTRB(30.0, 30.0, 50.0, 0.0),
            child: const Center(
              child: Text(
                'Bus Schedule',
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Wellfleet',
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        shadowColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
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
      body: StreamBuilder(
        stream: busScheduleCollection?.orderBy('number', descending: false).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.blue[900],
                strokeWidth: 3.0,
              ),
            );
          }
          if(busLine == 'none') {
              return  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
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
                  ),
                   Center(
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width - MediaQuery.sizeOf(context).width * .20,
                      child: const Text('Please Wait For The Bus Administrator to Assign A Bus Line!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Wellfleet',
                        fontSize: 18.0,
                      ),),
                    ),
                  ),
                ],
              );
          }
          else{
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = snapshot.data!.docs[index];
                Map<String, dynamic> data =
                document.data() as Map<String, dynamic>;
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                      margin: const EdgeInsets.all(14.0),
                      width: MediaQuery.of(context).size.width - 20 ,
                      height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height *.83,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: Colors.blue.shade900,
                          width: 2.0,
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 4.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  dateFormat,
                                  style: const TextStyle(
                                      fontSize: 13.0, fontFamily: 'Wellfleet'),
                                ),
                                Text(
                                  'Arriving ${data['arrivaltimeR1']}',
                                  style: const TextStyle(
                                      fontSize: 13.0, fontFamily: 'Wellfleet'),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                            width: MediaQuery.of(context).size.width - 20,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.directions_bus_sharp,
                                  color: Colors.blue[900],
                                  size: 30,
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Container(
                                  width: 40.0,
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(0, 169, 224, 1.0),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${data['busNumber']}',
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                        fontFamily: 'Wellfleet',
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width - MediaQuery.sizeOf(context).width* .75 ,
                                  child: Center(
                                    child: Text(
                                      '${data['originalPlace']}',
                                      style: const TextStyle(
                                        fontSize: 14.5,
                                        fontFamily: 'Wellfleet',
                                      ),
                                    ),
                                  ),
                                ),
                                const Text('------->'),
                                const SizedBox(width: 7.0,),
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width - MediaQuery.sizeOf(context).width* .75,
                                  child: Center(
                                    child: Text(
                                      document.id,
                                      style: const TextStyle(
                                        fontSize: 14.5,
                                        fontFamily: 'Wellfleet',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                      margin: const EdgeInsets.all(14.0),
                      width: MediaQuery.of(context).size.width - 20 ,
                      height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height *.83,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: Colors.blue.shade900,
                          width: 2.0,
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 4.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  dateFormat,
                                  style: const TextStyle(
                                      fontSize: 13.0, fontFamily: 'Wellfleet'),
                                ),
                                Text(
                                  'Arriving ${data['arrivaltimeR2']}',
                                  style: const TextStyle(
                                      fontSize: 13.0, fontFamily: 'Wellfleet'),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                            width: MediaQuery.of(context).size.width - 20,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.directions_bus_sharp,
                                  color: Colors.blue[900],
                                  size: 30,
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Container(
                                  width: 40.0,
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(0, 169, 224, 1.0),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${data['busNumber']}',
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                        fontFamily: 'Wellfleet',
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width - MediaQuery.sizeOf(context).width* .75 ,
                                  child: Center(
                                    child: Text(
                                      '${data['originalPlace']}',
                                      style: const TextStyle(
                                        fontSize: 14.5,
                                        fontFamily: 'Wellfleet',
                                      ),
                                    ),
                                  ),
                                ),
                                const Text('------->'),
                                const SizedBox(width: 7.0,),
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width - MediaQuery.sizeOf(context).width* .75,
                                  child: Center(
                                    child: Text(
                                      document.id,
                                      style: const TextStyle(
                                        fontSize: 14.5,
                                        fontFamily: 'Wellfleet',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
