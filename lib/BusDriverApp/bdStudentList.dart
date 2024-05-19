import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:psut_my_bus/BusDriverApp/Students.dart';
import 'package:psut_my_bus/BusDriverApp/bdBottomNavBar.dart';
import 'package:psut_my_bus/BusDriverApp/bdQRScanner.dart';


class BDStudentList extends StatefulWidget {
  const BDStudentList({super.key});

  @override
  State<BDStudentList> createState() => _BDStudentListState();
}

class _BDStudentListState extends State<BDStudentList> {
  String dateFormat = DateFormat('EEEE, MMM d, yyyy').format(DateTime.now());
  late CollectionReference<Object?>? busScheduleCollection =  FirebaseFirestore.instance.collection('markers').doc('Tabarbour').collection('Routes3'); // return null if the document does not exist;
  String busLine = '';


  Future<void> _initBusScheduleCollection() async {
    CollectionReference<Object?>? tempBusScheduleCollection = await readData();
    if (tempBusScheduleCollection != null) {
      setState(() {
        busScheduleCollection = tempBusScheduleCollection;
      });
    }
  }

  Future<CollectionReference<Object?>?> readData() async {
    User? user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('drivers').doc(user?.uid).get();
    if (documentSnapshot.exists) {
      busLine = documentSnapshot.get('busLine');
      print(busLine);
      if (busLine == 'Marj Al Hammam') {
        return FirebaseFirestore.instance.collection('markers').doc('Marj Al Hammam').collection('Routes2');
      } else if (busLine == 'Madinah ') {
        return FirebaseFirestore.instance.collection('markers').doc('Madinah ').collection('Routes');
      }
      else if (busLine == 'Tabarbour ') {
        return FirebaseFirestore.instance.collection('markers').doc('Tabarbour').collection('Routes3');
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
                MaterialPageRoute(builder: (context) => const NavBar()),
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
                    // Container(
                    //   padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                    //   margin: const EdgeInsets.all(14.0),
                    //   width: MediaQuery.of(context).size.width - 20 ,
                    //   height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height *.83,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(20.0),
                    //     border: Border.all(
                    //       color: Colors.blue.shade900,
                    //       width: 2.0,
                    //     ),
                    //   ),
                    //   child: Column(
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 10.0),
                    //         child: Row(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Text(
                    //               dateFormat,
                    //               style: const TextStyle(
                    //                   fontSize: 13.0, fontFamily: 'Wellfleet'),
                    //             ),
                    //             Text(
                    //               'Arriving ${data['arrivaltimeR1'] ?? data['arrivaltimeR1']}',
                    //               style: const TextStyle(
                    //                   fontSize: 13.0, fontFamily: 'Wellfleet'),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       Container(
                    //         padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                    //         width: MediaQuery.of(context).size.width - 20,
                    //         child: Row(
                    //           children: [
                    //             Icon(
                    //               Icons.directions_bus_sharp,
                    //               color: Colors.blue[900],
                    //               size: 30,
                    //             ),
                    //             const SizedBox(
                    //               width: 10.0,
                    //             ),
                    //             Container(
                    //               width: 40.0,
                    //               decoration: BoxDecoration(
                    //                 color: const Color.fromRGBO(0, 169, 224, 1.0),
                    //                 borderRadius: BorderRadius.circular(20.0),
                    //               ),
                    //               child: Center(
                    //                 child: Text(
                    //                   '${data['busNumber'] ?? data['busNumber'] }',
                    //                   style: const TextStyle(
                    //                     fontSize: 15.0,
                    //                     fontFamily: 'Wellfleet',
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //             const SizedBox(
                    //               width: 10.0,
                    //             ),
                    //             SizedBox(
                    //               width: 50,
                    //               child: Center(
                    //                 child: Text(
                    //                    '${data['originalPlace'] ?? data['originalPlace']}',
                    //                   style: const TextStyle(
                    //                     fontSize: 15.0,
                    //                     fontFamily: 'Wellfleet',
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //             const SizedBox(
                    //               width: 10.0,
                    //             ),
                    //             const Text('------->'),
                    //             const SizedBox(
                    //               width: 10.0,
                    //             ),
                    //             SizedBox(
                    //               width: 100,
                    //               child: Text(
                    //                 document.id,
                    //                 style: const TextStyle(
                    //                   fontSize: 15.0,
                    //                   fontFamily: 'Wellfleet',
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                      margin: const EdgeInsets.all(14.0),
                      width: MediaQuery.of(context).size.width - 20 ,
                      height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height *.80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: Colors.blue.shade900,
                          width: 2.0,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                dateFormat,
                                style: const TextStyle(
                                    fontSize: 13.0, fontFamily: 'Wellfleet'),
                              ),
                              Text(
                                'Arriving ${data['arrivaltimeR2'] ?? data['arrivaltimeR2']}',
                                style: const TextStyle(
                                    fontSize: 13.0, fontFamily: 'Wellfleet'),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 5,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.directions_bus_sharp,
                                  color: Colors.blue[900],
                                  size: 30,
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Container(
                                  width: 40.0,
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(0, 169, 224, 1.0),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                       '${data['busNumber'] ?? data['busNumber']}',
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                        fontFamily: 'Wellfleet',
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15.0,
                                ),
                                SizedBox(
                                  width: 50,
                                  child: Center(
                                    child: Text(
                                      '${data['originalPlace'] ?? data['originalPlace']}',
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
                                const Text('------->'),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width * .40,
                                  child: Text(
                                    document.id,
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'Wellfleet',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width * .60,
                                child: ElevatedButton(
                                    onPressed: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const BDQRScan()),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      side: BorderSide(
                                        color: Colors.blue.shade900,
                                        width: 1
                                      )
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Icon(
                                            Icons.qr_code_scanner_sharp,
                                            color: Colors.blue.shade900,
                                          ),
                                        ),
                                        Text(
                                          'Scan the Student QR!',
                                          style: TextStyle(
                                            fontFamily: 'Wellfleet',
                                            fontSize: 15.0,
                                            color: Colors.blue.shade900
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const AlertDialog(
                                          title: Text('Students'),
                                          content: SizedBox(
                                            width:300,
                                            height: 300,
                                            // child: StudentList(students: widget.students),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  icon: Icon(Icons.arrow_drop_down_circle_outlined,
                                    color: Colors.blue.shade900,
                                    size: 30,))
                            ],
                          ),

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

class StudentList extends StatelessWidget {
  final List<Student> students;

  const StudentList({super.key, required this.students});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];
          return ListTile(
            title: Text(student.name),
            subtitle: Text(student.id),
          );
        },
      ),
    );
  }
}