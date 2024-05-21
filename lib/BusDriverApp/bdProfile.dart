import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:psut_my_bus/BusDriverApp/bdProfileEdit.dart';
import 'bdSettings.dart';

class BDProfile extends StatelessWidget{
  BDProfile({super.key});

  final storage = FirebaseStorage.instance;
  final CollectionReference users = FirebaseFirestore.instance.collection('drivers');
  final  User? user = FirebaseAuth.instance.currentUser;

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
                MaterialPageRoute(builder: (context) => BDSettings()),
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
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Center(
                      child: Text('Profile',
                          style: TextStyle(
                            fontFamily: 'Wellfleet',
                            fontSize: 30.0,
                          )),
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(data['imageLink'] ?? 'none'),
                      backgroundColor: Colors.blue[900],
                      radius: 80.0,
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width - MediaQuery.sizeOf(context).width * .10,
                      child: TextField(
                        enabled: false,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                const BorderSide(color: Colors.black)),
                            labelText: 'First Name: ${data['firstName'] ?? 'none'}',
                            labelStyle: const TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'Wellfleet',
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            )),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width - MediaQuery.sizeOf(context).width * .10,
                      child: TextField(
                        enabled: false,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                const BorderSide(color: Colors.black)),
                            labelText: 'Last Name: ${data['lastName'] ?? 'none'}',
                            labelStyle: const TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'Wellfleet',
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            )),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width - MediaQuery.sizeOf(context).width * .10,
                      child: TextField(
                        enabled: false,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                const BorderSide(color: Colors.black)),
                            labelText: 'Employee ID: ${data['empID'] ?? 'none'}',
                            labelStyle: const TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'Wellfleet',
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            )),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width - MediaQuery.sizeOf(context).width * .10,
                      child: TextField(
                        enabled: false,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                const BorderSide(color: Colors.black)),
                            labelText: 'Phone Number: ${data['phoneNumber'] ?? 'none'}',
                            labelStyle: const TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'Wellfleet',
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            )),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width - MediaQuery.sizeOf(context).width * .10,
                      child: TextField(
                        enabled: false,
                        readOnly: true,
                        cursorColor: Colors.redAccent,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    width: 5.0, color: Colors.black)),
                            labelText: "Email: ${data['email'] ?? 'none'}",
                            labelStyle: const TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'Wellfleet',
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            )),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width - MediaQuery.sizeOf(context).width * .10,
                      child: TextField(
                        enabled: false,
                        readOnly: true,
                        cursorColor: Colors.redAccent,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    width: 5.0, color: Colors.black)),
                            labelText: "Bus Line: ${data['busLine'] ?? 'none'}",
                            labelStyle: const TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'Wellfleet',
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            )),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                      width: MediaQuery.sizeOf(context).width - MediaQuery.sizeOf(context).width * .10,
                      height: 50.0,
                      child: ElevatedButton(
                          onPressed: () async {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) =>  const BDProfileEdit()));
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
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text('Edit',
                                style: TextStyle(
                                  color: Color.fromRGBO(0, 169, 224, 1.0),
                                  fontSize: 16.0,
                                  fontFamily: 'Wellfleet',
                                  fontWeight: FontWeight.w500,
                                )),
                          )),
                    ),
                  ],
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
          }
      ),
    );
  }
}
