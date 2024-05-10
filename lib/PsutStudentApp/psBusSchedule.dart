import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'psBottomNavBar.dart';


class PSBusSchedule extends StatefulWidget {
  PSBusSchedule({super.key});

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
        backgroundColor: Colors.white,
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
        stream: busScheduleCollection?.snapshots(),
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
              return  const Center(
                child: SizedBox(
                  width: 250.0,
                  child: Center(
                    child: Text('Please Wait For The Bus Administrator to Assign A Bus Line',
                    style: TextStyle(
                      fontFamily: 'Wellfleet',
                      fontSize: 20.0,
                    ),),
                  ),
                ),
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
                      padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                      margin: const EdgeInsets.all(14.0),
                      width: MediaQuery.of(context).size.width,
                      height: 170,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: Colors.blue.shade900,
                          width: 2.0,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                dateFormat,
                                style: const TextStyle(
                                    fontSize: 15.0, fontFamily: 'Wellfleet'),
                              ),
                              Text(
                                'Arriving ${data['arrivaltimeR1']}',
                                style: const TextStyle(
                                    fontSize: 15.0, fontFamily: 'Wellfleet'),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.directions_bus_sharp,
                                color: Colors.blue[900],
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
                                width: 120.0,
                                child: Center(
                                  child: Text(
                                    '${data['originalPlace']}',
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'Wellfleet',
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              const Text('------->'),
                              const SizedBox(
                                width: 5.0,
                              ),
                              SizedBox(
                                width: 130.0,
                                child: Center(
                                  child: Text(
                                    document.id,
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'Wellfleet',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                      margin: const EdgeInsets.all(14.0),
                      width: MediaQuery.of(context).size.width,
                      height: 170,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: Colors.blue.shade900,
                          width: 2.0,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                dateFormat,
                                style: const TextStyle(
                                    fontSize: 15.0, fontFamily: 'Wellfleet'),
                              ),
                              Text(
                                'Arriving ${data['arrivaltimeR2']}',
                                style: const TextStyle(
                                    fontSize: 15.0, fontFamily: 'Wellfleet'),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.directions_bus_sharp,
                                color: Colors.blue[900],
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
                                width: 120.0,
                                child: Center(
                                  child: Text(
                                    '${data['originalPlace']}',
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'Wellfleet',
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              const Text('------->'),
                              const SizedBox(
                                width: 5.0,
                              ),
                              SizedBox(
                                width: 130.0,
                                child: Center(
                                  child: Text(
                                    document.id,
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'Wellfleet',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(
              color: Colors.blue[900],
              strokeWidth: 3.0,
            ),
          );
        },
      ),
    );
  }
}
