import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'FireAuth.dart';
import 'psSettings.dart';

class PSChangePassword extends StatefulWidget {
  const PSChangePassword({super.key});

  @override
  State<PSChangePassword> createState() => _PSChangePasswordState();
}

class _PSChangePasswordState extends State<PSChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _oldPassword = TextEditingController();
  final _newPassword = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _oldPassword.dispose();
    _newPassword.dispose();
    super.dispose();
  }

  //Regression Expression for Student Email and Password
  bool isEmailValid(String email) {
    const pattern = r'^[a-zA-Z]{3}\d{8}@std.psut.edu.jo$';
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
            title: const Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(50.0, 30.0, 10.0, 0.0),
                child: SizedBox(
                  width: 290.0,
                  child: Text(
                    'Change Password',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Wellfleet',
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 50.0,
                ),
                Container(
                  height: 100.0,
                  alignment: Alignment.topLeft,
                  child: const Image(
                    image: AssetImage('assets/images/bg_logo.png'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 380.0,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _emailController,
                            validator: (psEmail) {
                              if (isEmailValid(psEmail!)) {
                                return null;
                              } else {
                                return 'Invalid Student Email!';
                              }
                            },
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.fromLTRB(
                                    10.0, 0.0, 15.0, 0.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        const BorderSide(color: Colors.black)),
                                labelText: "Student Email:",
                                labelStyle: const TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: 'Wellfleet',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                )),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            controller: _oldPassword,
                            validator: (psPassword) {
                              if (isPasswordValid(psPassword!)) {
                                return null;
                              } else {
                                return 'Invalid Current Password!';
                              }
                            },
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.fromLTRB(
                                    10.0, 0.0, 15.0, 0.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        const BorderSide(color: Colors.black)),
                                labelText: "Current Password:",
                                labelStyle: const TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: 'Wellfleet',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                )),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const SizedBox(
                            width: 370.0,
                            child: Text(
                                'The new password must be different from the current password'),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            controller: _newPassword,
                            validator: (psPassword) {
                              if (isPasswordValid(psPassword!)) {
                                return null;
                              } else {
                                return 'Invalid New Password!';
                              }
                            },
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.fromLTRB(
                                    10.0, 0.0, 15.0, 0.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        const BorderSide(color: Colors.black)),
                                labelText: "New Password:",
                                labelStyle: const TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: 'Wellfleet',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                )),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: 320.0,
                  height: 48.0,
                  child: ElevatedButton(
                      onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          User? user = (await FireAuth.changePassword(
                            currentPassword: _oldPassword.text,
                            newPassword: _newPassword.text,
                            email: _emailController.text,
                          ));
                          _showChangedPasswordDialog(context);
                        }
                        on FirebaseAuthException catch(e) {
                          print(e);
                        }
                      }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(11, 39, 143, 1.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0)),
                      ),
                      child: const Text(
                        'SUBMIT',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Wellfleet',
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      )),
                ),
              ],
            ),
          ),
        ));
  }
}
void _showChangedPasswordDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shadowColor: Colors.blue[900],
        backgroundColor: Colors.white,
        title: const Center(
          child:  Text('Password Changed!',
              style: TextStyle(
                fontFamily: 'Wellfleet',
                fontSize: 20.0,
                color: Colors.black,
              )),
        ),
        content: const Text('The Password have changed!',
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontFamily: 'Wellfleet',
              fontSize: 16.0,
              color: Colors.black,
            )),
        actions:  <Widget>[
          Center(
            child: ElevatedButton(
              child: const Text('OK',
                  style: TextStyle(
                    fontFamily: 'Wellfleet',
                    fontSize: 15.0,
                    color: Colors.black,
                  )),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      );
    },
  );
}