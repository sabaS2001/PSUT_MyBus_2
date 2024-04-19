import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:psut_my_bus/PsutStudentApp/psProfileEdit.dart';
import 'psSettings.dart';

class PSProfile extends StatefulWidget {
  const PSProfile({super.key});

  @override
  State<PSProfile> createState() => _PSProfileState();
}

class _PSProfileState extends State<PSProfile> {

  CollectionReference users = FirebaseFirestore.instance.collection('students');
  User? user = FirebaseAuth.instance.currentUser;


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
                MaterialPageRoute(builder: (context) => const PSSettings()),
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
      body: FutureBuilder(
          future:  users.doc(user?.uid).get(),
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.done){
              if(snapshot.hasData && snapshot.data!.exists){
                Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                // return Text('First Name: ${data['firstName']}');
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Center(
                        child: Text('Profile',
                            style: TextStyle(
                              fontFamily: 'Wellfleet',
                              fontSize: 30.0,
                            )),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/logo.png'),
                        backgroundColor: Colors.transparent,
                        radius: 80.0,
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: 340.0,
                            child: TextField(
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide:
                                      const BorderSide(color: Colors.black)),
                                  labelText: 'First Name: ${data['firstName']}',
                                  labelStyle: const TextStyle(
                                    fontSize: 15.0,
                                    fontFamily: 'Wellfleet',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  )),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          SizedBox(
                            width: 340.0,
                            child: TextField(
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide:
                                      const BorderSide(color: Colors.black)),
                                  labelText: 'Last Name: ${data['lastName']}',
                                  labelStyle: const TextStyle(
                                    fontSize: 15.0,
                                    fontFamily: 'Wellfleet',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  )),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          SizedBox(
                            width: 340.0,
                            child: TextField(
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide:
                                      const BorderSide(color: Colors.black)),
                                  labelText: 'Student ID: ${data['studentID']}',
                                  labelStyle: const TextStyle(
                                    fontSize: 15.0,
                                    fontFamily: 'Wellfleet',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  )),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          SizedBox(
                            width: 340.0,
                            child: TextField(
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide:
                                      const BorderSide(color: Colors.black)),
                                  labelText: 'Email: ${data['email']}',
                                  labelStyle: const TextStyle(
                                    fontSize: 15.0,
                                    fontFamily: 'Wellfleet',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  )),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          SizedBox(
                            width: 340.0,
                            child: TextField(
                              readOnly: true,
                              cursorColor: Colors.redAccent,
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                          width: 5.0, color: Colors.black)),
                                  labelText: "Bus Line (Read-Only):",
                                  labelStyle: const TextStyle(
                                    fontSize: 15.0,
                                    fontFamily: 'Wellfleet',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  )),
                            ),
                          ),
                          const SizedBox(height: 70.0),
                          SizedBox(
                            width: 310.0,
                            height: 50.0,
                            child: ElevatedButton(
                                onPressed: () async {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>  const PSProfileEdit()));
                                },
                                style: ElevatedButton.styleFrom(
                                  side: const BorderSide(
                                      width: 1.8,
                                      color: Color.fromRGBO(0, 24, 113, 1.0)),
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40.0),
                                  ),
                                ),
                                child: const Text('Edit',
                                    style: TextStyle(
                                      color: Color.fromRGBO(0, 169, 224, 1.0),
                                      fontSize: 16.0,
                                      fontFamily: 'Wellfleet',
                                      fontWeight: FontWeight.w500,
                                    ))),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              }
              return  Text('${user?.uid}');
            }
            return const Text('loading....');
          }
      ),
      );
  }
}