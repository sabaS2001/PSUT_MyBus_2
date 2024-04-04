import 'package:flutter/material.dart';
import 'bdSettings.dart';

class BDProfile extends StatelessWidget with InputValidationProfileMixin {
  BDProfile({super.key});
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
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
                  MaterialPageRoute(builder: (context) => const BDSettings()),
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
                    width: 350.0,
                    child: TextFormField(
                      validator: (fName) {
                        if (isNameValid(fName!)) {
                          return null;
                        } else {
                          return 'Invalid First Name!';
                        }
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          errorStyle: TextStyle(
                            color: Colors.red[900],
                            fontSize: 16.0,
                            fontFamily: 'Wellfleet',
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(color: Colors.black)),
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
                      validator: (lName) {
                        if (isNameValid(lName!)) {
                          return null;
                        } else {
                          return 'Invalid Last Name!';
                        }
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          errorStyle: TextStyle(
                            color: Colors.red[900],
                            fontSize: 16.0,
                            fontFamily: 'Wellfleet',
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(color: Colors.black)),
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
                      validator: (bdId) {
                        if (isIDValid(bdId!)) {
                          return null;
                        } else {
                          return 'Invalid ID!';
                        }
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          errorStyle: TextStyle(
                            color: Colors.red[900],
                            fontSize: 16.0,
                            fontFamily: 'Wellfleet',
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(color: Colors.black)),
                          labelText: "Bus Driver ID:",
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
                      validator: (email) {
                        if (isEmailValid(email!)) {
                          return null;
                        } else {
                          return 'Invalid Email!';
                        }
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          errorStyle: TextStyle(
                            color: Colors.red[900],
                            fontSize: 16.0,
                            fontFamily: 'Wellfleet',
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(color: Colors.black)),
                          labelText: "Employee Email:",
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
                      validator: (phoneNum) {
                        if (isPhoneValid(phoneNum!)) {
                          return null;
                        } else {
                          return 'Invalid Phone Number!';
                        }
                      },
                      cursorColor: Colors.redAccent,
                      obscureText: false,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          errorStyle: TextStyle(
                            color: Colors.red[900],
                            fontSize: 16.0,
                            fontFamily: 'Wellfleet',
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(width: 5.0, color: Colors.black)),
                          labelText: "Phone Number:",
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
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const BDSettings()));
                            }
                        },
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(
                              width: 1.8, color: Color.fromRGBO(0, 24, 113, 1.0)),
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
      ),
    );
  }
}

mixin InputValidationProfileMixin {
  //regression expression for first name and last name
  bool isNameValid(String name){
    const pattern = r'^[a-zA-Z]+$';
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(name);
  }
  //regression expression for bus driver id
  bool isIDValid(String bdId) {
    const pattern = r'^\d+$';
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(bdId) && bdId.length == 8;
  }
  //regression expression for bus driver email
  bool isEmailValid(String email){
    const pattern = r'^\d{8}@psut.edu.jo$';
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(email);
  }
  //regression expression for phone number
  bool isPhoneValid(String phoneNum){
    const pattern = r'^07\d{8}$';
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(phoneNum) && phoneNum.length == 10;
  }
}