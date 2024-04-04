import 'dart:core';
import 'package:flutter/material.dart';
import 'bdBottomNavBar.dart';
import 'package:flutter_regex/flutter_regex.dart';


//Bus Driver Login Page
class BDLogin extends StatelessWidget {
  const BDLogin({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LoginValidation(),
    );
  }
}
class LoginValidation extends StatelessWidget with InputValidationMixin {
  LoginValidation({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  image: AssetImage('assets/images/bg_logo.png',),
                ),
              ],
            ),
            const SizedBox(height: 50.0,),
            const Text('PSUT MyBus',
                style: TextStyle(
                  fontFamily: 'Wellfleet',
                  fontSize: 42.0,
                )),
            const SizedBox(height: 30.0),
            const CircleAvatar(
              //Logo of PSUT
              backgroundColor: Colors.white30,
              backgroundImage: AssetImage('assets/images/logo.png'),
              radius: 100.0,
            ),
            const SizedBox(height: 20.0), //Space between logo and input box
            SizedBox(
              width: 350.0,
              child: TextFormField(
                  validator: (id) {
                    if (isIDValid(id!)) {
                      return null;
                    } else {
                      return 'Enter a valid email address';
                    }
                  },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    errorStyle: TextStyle(
                      color: Colors.red[900],
                      fontSize: 16.0,
                      fontFamily: 'Wellfleet',
                    ),
                    hintText: 'Enter Your Staff ID',
                    hintStyle: TextStyle(
                      color: Colors.blue[900],
                      fontSize: 16.0,
                      fontFamily: 'Wellfleet',
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: "Bus Driver ID:",
                    labelStyle: const TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'Wellfleet',
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    )),
              ),
            ),
            const SizedBox(height: 15.0), //Space between input boxes
            SizedBox(
              width: 350.0,
              child: TextFormField(
                validator: (password) {
                  if (isPasswordValid(password!)) {
                    return null;
                  } else {
                    return 'Enter a valid password';
                  }
                },
                obscureText: true,
                decoration: InputDecoration(
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    errorStyle: TextStyle(
                      color: Colors.red[900],
                      fontSize: 16.0,
                      fontFamily: 'Wellfleet',
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    hintText: 'Enter Your Password',
                    hintStyle: TextStyle(
                      color: Colors.blue[900],
                      fontSize: 16.0,
                      fontFamily: 'Wellfleet',
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: "Password:",
                    labelStyle: const TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'Wellfleet',
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    )),
              ),
            ),
            const SizedBox(height: 30.0), //Space between input box and the button
            SizedBox(
              width: 320.0,
              height: 48.0,
              child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const NavBar()));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(11, 39, 143, 1.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0)),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Wellfleet',
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  )),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 90.0, horizontal: 0.0) ),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image(image: AssetImage('assets/images/bg_logo2.png'))
                ],
            )
          ],
        ),
      ),

    );
  }
}

mixin InputValidationMixin {
  bool isPasswordValid(String password){
    if (password.length == 8) {
      return true;
    } else {
      return false;
    }
  }
  bool isIDValid(String id) {
    const pattern = r'^\d+$';
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(id) && id.length == 8;
  }
}