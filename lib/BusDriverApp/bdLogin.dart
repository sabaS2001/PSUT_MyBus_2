import 'package:flutter/material.dart';
import 'bdBottomNavBar.dart';
//Bus Driver Login Page
class BDLogin extends StatelessWidget {
  const BDLogin({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: LoginValidation(),
    );
  }
}
class LoginValidation extends StatefulWidget {
  const LoginValidation({super.key});
  @override
  State<LoginValidation> createState() => _LoginValidationState();
}

class _LoginValidationState extends State<LoginValidation> {

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
              //Input Box of Bus Driver ID
              width: 350.0,
              height: 48.0,
              child: TextFormField(
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                obscureText: true,
                decoration: InputDecoration(
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    errorStyle: TextStyle(
                      color: Colors.blue[900],
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
              // Input Box of Password
              width: 350.0,
              height: 48.0,
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
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
                  onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const NavBar()),
                       );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(11, 39, 143, 1.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0)),
                  ),
                  child: const Text(
                    'Login',
                    style: const TextStyle(
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

