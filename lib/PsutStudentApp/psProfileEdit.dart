import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:psut_my_bus/PsutStudentApp/psProfile.dart';


class PSProfileEdit extends StatefulWidget {
  const PSProfileEdit({super.key});

  @override
  State<PSProfileEdit> createState() => _PSProfileState();
}

class _PSProfileState extends State<PSProfileEdit> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _studentIDController = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('students');
  User? user = FirebaseAuth.instance.currentUser;

  //regression expression for first name and last name
  bool isNameValid(String name) {
    const pattern = r'^[a-zA-Z]+$';
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(name);
  }

  //regression expression for psut student id
  bool isIDValid(String bdId) {
    const pattern = r'^\d+$';
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(bdId) && bdId.length == 8;
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: FutureBuilder (
        future: users.doc(user?.uid).get(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasData && snapshot.data!.exists){
              Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
              // return Text('First Name: ${data['firstName']}');
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
                          MaterialPageRoute(builder: (context) => const PSProfile()),
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
                            child: TextFormField(
                              controller: _firstNameController,
                              validator: (fName) {
                                if (isNameValid(fName!)) {
                                  return null;
                                } else {
                                  return 'Invalid First Name!';
                                }
                              },
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide:
                                      const BorderSide(color: Colors.black)),
                                  labelText: "First Name:",
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
                            child: TextFormField(
                              controller: _lastNameController,
                              validator: (lName) {
                                if (isNameValid(lName!)) {
                                  return null;
                                } else {
                                  return 'Invalid Last Name!';
                                }
                              },
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide:
                                      const BorderSide(color: Colors.black)),
                                  labelText: "Last Name:",
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
                            child: TextFormField(
                              controller: _studentIDController,
                              validator: (psID) {
                                if (isIDValid(psID!)) {
                                  return null;
                                } else {
                                  return 'Invalid Student ID!';
                                }
                              },
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide:
                                      const BorderSide(color: Colors.black)),
                                  labelText: "Student ID:",
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
                            child: TextFormField(
                              enabled: false,
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
                              enabled: false,
                              cursorColor: Colors.redAccent,
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                          width: 5.0, color: Colors.black)),
                                  labelText: "Bus Line: ${data['busLine']}",
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
                                  if (_formKey.currentState!.validate()) {
                                    final user = this.user;
                                    if (user != null) {
                                      try {
                                        await FirebaseFirestore.instance
                                            .collection('students')
                                            .doc(user.uid)
                                            .update({
                                          'firstName':
                                          _firstNameController.text.toString(),
                                          'lastName':
                                          _lastNameController.text,
                                          'studentID':
                                          _studentIDController.text
                                        });

                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                              content:
                                              Text('Profile updated successfully')),
                                        );
                                      } catch (e) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                              content:
                                              Text('Error updating profile: $e')),
                                        );
                                      }
                                    }
                                  }
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
                                child: const Text('Save',
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
                ),
              );
            }
            return  Text('${user?.uid}');
          }
          return const Text('loading....');
        },
      )
      ,
    );
  }
}
