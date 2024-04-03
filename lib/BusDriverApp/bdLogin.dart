import 'package:flutter/material.dart';
import 'bdBottomNavBar.dart';
//Bus Driver Login Page
class BDLogin extends StatelessWidget {
  const BDLogin({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 100.0,
              alignment: Alignment.topLeft,
              child: const Image(
                image: AssetImage('images/bg_logo.png'),
              ),
            ),
            const Text('PSUT MyBus',
                style: TextStyle(
                  fontFamily: 'Wellfleet',
                  fontSize: 42.0,
                )),
            const SizedBox(height: 30.0),
            const CircleAvatar(
              //Logo of PSUT
              backgroundColor: Colors.white30,
              backgroundImage: AssetImage('images/logo.png'),
              radius: 100.0,
            ),
            const SizedBox(height: 10.0), //Space between logo and input box
            SizedBox(
              //Input Box of Bus Driver ID
              width: 350.0,
              height: 48.0,
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
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
            const SizedBox(height: 10.0), //Space between input boxes
            SizedBox(
              // Input Box of Password
              width: 350.0,
              height: 48.0,
              child: TextField(
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
            const SizedBox(height: 20.0), //Space between input box and the button
            SizedBox(
              width: 320.0,
              height: 48.0,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const NavBar()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(11, 39, 143, 1.0),
                    textStyle: const TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'Wellfleet',
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0)),
                  ),
                  child: const Text(
                    'Login',
                  )),
            ),
            const SizedBox(height: 45.0),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(width: 20.0),
                Image(image: AssetImage('images/bg_logo2.png'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
