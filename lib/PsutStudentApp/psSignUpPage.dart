import 'package:flutter/material.dart';
import 'package:psut_my_bus/PsutStudentApp/psLogin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'FireAuth.dart';

class PSSignUp extends StatefulWidget{
  const PSSignUp({super.key});

  @override
  State<PSSignUp> createState() => _PSSignUpState();
}

class _PSSignUpState extends State<PSSignUp>  with InputValidationPSSignUpMixin {
  final _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmedPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _studentIDController = TextEditingController();


  storeNewUser(user) async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    _firestore.collection('students').doc(firebaseUser!.uid).set({
      'firstName': _firstNameController.text,
      'lastName': _lastNameController.text,
      'email': _emailController.text,
      'studentID': _studentIDController.text,
      'password': _passwordController.text,
    });
  }


  @override
  void dispose (){
   _emailController.dispose();
   _passwordController.dispose();
   _confirmedPasswordController.dispose();
   _firstNameController.dispose();
   _lastNameController.dispose();
   _studentIDController.dispose();
   super.dispose();
 }

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is not signed in');
      } else {
        print('User is signed in: ${user.email}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.all(11.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PSLogin()),
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
                children: [
                  Image(
                    image: AssetImage('assets/images/bg_logo.png'),
                  ),
                  SizedBox(
                    width: 300.0,
                    child: Text('Sign Up',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Wellfleet',
                          fontSize: 30.0,
                        )),
                  ),
                ],
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
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          errorStyle: TextStyle(
                            color: Colors.red[900],
                            fontSize: 16.0,
                            fontFamily: 'Wellfleet',
                          ),
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
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          errorStyle: TextStyle(
                            color: Colors.red[900],
                            fontSize: 16.0,
                            fontFamily: 'Wellfleet',
                          ),
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
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          errorStyle: TextStyle(
                            color: Colors.red[900],
                            fontSize: 16.0,
                            fontFamily: 'Wellfleet',
                          ),
                          labelText: "Student ID Number:",
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
                    width: 335.0,
                    child: Text(
                      textAlign: TextAlign.justify,
                      'Make sure it matches the numbers on your student ID.',
                      style: TextStyle(
                        fontFamily: 'Wellfleet',
                        fontSize: 12.0,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    width: 340.0,
                    child: TextFormField(
                      controller: _emailController,
                      validator: (psEmail) {
                        if (isEmailValid(psEmail!)) {
                          return null;
                        } else {
                          return 'Invalid University Email!';
                        }
                      },
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: Colors.black)),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          errorStyle: TextStyle(
                            color: Colors.red[900],
                            fontSize: 16.0,
                            fontFamily: 'Wellfleet',
                          ),
                          labelText: "University Email:",
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
                    width: 335.0,
                    child: Text(
                      textAlign: TextAlign.justify,
                      'We will email you any important notifications regarding to the bus.',
                      style: TextStyle(
                        fontFamily: 'Wellfleet',
                        fontSize: 12.0,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    width: 340.0,
                    child: TextFormField(
                      controller: _passwordController,
                      validator: (password) {
                        if (isPasswordValid(password!)) {
                          return null;
                        } else {
                          return 'Invalid Password!';
                        }
                      },
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: Colors.black)),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          errorStyle: TextStyle(
                            color: Colors.red[900],
                            fontSize: 16.0,
                            fontFamily: 'Wellfleet',
                          ),
                          labelText: "Password:",
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
                      controller: _confirmedPasswordController,
                      validator: (password) {
                        if (isPasswordValid(password!)) {
                          return null;
                        } else {
                          return 'Invalid Confirmed Password!';
                        }
                      },
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: Colors.black)),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          errorStyle: TextStyle(
                            color: Colors.red[900],
                            fontSize: 16.0,
                            fontFamily: 'Wellfleet',
                          ),
                          labelText: "Confirmed Password:",
                          labelStyle: const TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'Wellfleet',
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          )),
                    ),
                  ),
                  const SizedBox(height: 50.0),
                  SizedBox(
                    width: 340.0,
                    height: 50.0,
                    child: ElevatedButton(
                        onPressed: () async {
                          if(_passwordController.text == _confirmedPasswordController.text) {
                            if (_formKey.currentState!.validate()) {
                              try {
                                User? user = await FireAuth
                                    .registerThroughEmail(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                                if (user != null) {
                                  if (await FireAuth.checkEmailExists(
                                      _emailController.text)) {
                                    storeNewUser(user);
                                    _showSucessDialog(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (
                                          context) => const PSLogin()),
                                    );
                                  }
                                }
                                else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                        Text('The Email Already Exist for Another User')),
                                  );
                                }
                              } on FirebaseAuthException catch (e) {
                                debugPrint(e as String?);
                              }
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(11, 39, 143, 1.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0)),
                        ),
                        child: const Text(
                          'Agree & Continue',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontFamily: 'Wellfleet',
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        )),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 20.0,
                        height: 250.0,
                      ),
                      Image(image: AssetImage('assets/images/bg_logo2.png'))
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

mixin InputValidationPSSignUpMixin {
  //regression expression for first name and last name
  bool isNameValid(String name){
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
  //regression expression for psut student email
  bool isEmailValid(String email) {
    const pattern = r'^[a-zA-Z]{3}\d{8}@std.psut.edu.jo$'; //r'^[a-zA-Z]{3}\d{8}@std.psut.edu.jo$';
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(email);
  }
  bool isPasswordValid(String password) {
    if (password.length == 8) {
      return true;
    } else {
      return false;
    }
  }

}

void _showSucessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shadowColor: Colors.blue[900],
        backgroundColor: Colors.white,
        title: const Center(
          child: Text('Account is Created!',
              style: TextStyle(
                fontFamily: 'Wellfleet',
                fontSize: 20.0,
                color: Colors.black,
              )),
        ),
        content: const Text('Please login with same email and password!',
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontFamily: 'Wellfleet',
              fontSize: 16.0,
              color: Colors.black,
            )),
        actions: <Widget>[
          Center(
            child: ElevatedButton(
              child: const Text('OK',
                  style: TextStyle(
                    fontFamily: 'Wellfleet',
                    fontSize: 15.0,
                    color: Colors.black,
                  )),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ),
        ],
      );
    },
  );
}
void _showErrorDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shadowColor: Colors.blue[900],
        backgroundColor: Colors.white,
        title: const Center(
          child: Text('Incorrect Password!',
              style: TextStyle(
                fontFamily: 'Wellfleet',
                fontSize: 20.0,
                color: Colors.black,
              )),
        ),
        content: const Text('The Confirmed Password Does Not Match With Password Field',
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontFamily: 'Wellfleet',
              fontSize: 16.0,
              color: Colors.black,
            )),
        actions: <Widget>[
          Center(
            child: ElevatedButton(
              child: const Text('OK',
                  style: TextStyle(
                    fontFamily: 'Wellfleet',
                    fontSize: 15.0,
                    color: Colors.black,
                  )),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ),
        ],
      );
    },
  );
}