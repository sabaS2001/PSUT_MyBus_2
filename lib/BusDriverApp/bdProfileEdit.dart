import 'dart:typed_data' ;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:psut_my_bus/BusDriverApp/bdProfile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:psut_my_bus/utils/utils.dart';
import 'package:psut_my_bus/resources/addData.dart';

class BDProfileEdit extends StatefulWidget {
  const BDProfileEdit({super.key});

  @override
  State<BDProfileEdit> createState() => _BDProfileEditState();
}

class _BDProfileEditState extends State<BDProfileEdit> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _empIDController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  Uint8List? _image;

  CollectionReference users = FirebaseFirestore.instance.collection('drivers');
  User? user = FirebaseAuth.instance.currentUser;

  //regression expression for first name and last name
  bool isNameValid(String name) {
    const pattern = r'^[a-zA-Z]+$';
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(name);
  }

  //regression expression for psut employee id
  bool isIDValid(String bdId) {
    const pattern = r'^\d+$';
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(bdId) && bdId.length == 8;
  }

  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState((){
      _image = image;
    });
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
                          MaterialPageRoute(builder: (context) => BDProfile()),
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
                            child: SizedBox(
                              height: MediaQuery.sizeOf(context).height,
                              child: Column(
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
                                  Stack(
                                    children: [
                                      _image != null ?
                                      CircleAvatar(
                                        radius: 80.0,
                                        backgroundImage: MemoryImage(_image!) ,
                                      ) :
                                      const CircleAvatar(
                                        backgroundImage: AssetImage('assets/images/logo.png'),
                                        backgroundColor: Colors.transparent,
                                        radius: 80.0,
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        left:100,
                                        child: IconButton(
                                          style: ButtonStyle(
                                            backgroundColor: WidgetStateProperty.all(Colors.white70),
                                          ),
                                          onPressed: () {
                                            selectImage();
                                          },
                                          icon: Icon(
                                            Icons.add_a_photo_rounded,
                                            color: Colors.blue.shade900,
                                          ),
                                        ),
                                      )
                                    ],
                              
                                  ),
                                  SizedBox(
                                    width: MediaQuery.sizeOf(context).width - MediaQuery.sizeOf(context).width * .10,                                    child: TextFormField(
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
                                  SizedBox(
                                    width: MediaQuery.sizeOf(context).width - MediaQuery.sizeOf(context).width * .10,
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
                                  SizedBox(
                                    width: MediaQuery.sizeOf(context).width - MediaQuery.sizeOf(context).width * .10,
                                    child: TextFormField(
                                      controller: _empIDController,
                                      validator: (ID) {
                                        if (isIDValid(ID!)) {
                                          return null;
                                        } else {
                                          return 'Invalid Employee ID!';
                                        }
                                      },
                                      decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 10.0),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                              borderSide:
                                              const BorderSide(color: Colors.black)),
                                          labelText: "Employee ID:",
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
                                    child: TextFormField(
                                     controller: _phoneNumberController,
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
                                  SizedBox(
                                    width: MediaQuery.sizeOf(context).width - MediaQuery.sizeOf(context).width * .10,
                                    height: 50.0,
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          if (_formKey.currentState!.validate()) {
                                            final user = this.user;
                                            if (user != null) {
                                              try {
                                                String imageURL = await StoreData().uploadImageToStorage('profileImage', _image!);
                                                await FirebaseFirestore.instance
                                                    .collection('drivers')
                                                    .doc(user.uid)
                                                    .update({
                                                  'firstName': _firstNameController.text,
                                                  'lastName': _lastNameController.text,
                                                  'empID': _empIDController.text,
                                                  'phoneNumber': _phoneNumberController.text,
                                                  'imageLink': imageURL,
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
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        return  Text('${user?.uid}');
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.blue[900],
                          strokeWidth: 3.0,
                        ),
                      );
                    }
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
          return  Padding(
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
        },
      )
      ,
    );
  }
}
