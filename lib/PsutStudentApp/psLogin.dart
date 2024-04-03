import 'dart:ui';
import 'package:flutter/material.dart';
import 'psForgetPassword.dart';
import 'psBottomNavBar.dart';


class PSLogin extends StatelessWidget {
  const PSLogin({super.key});

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
                image:AssetImage('assets/images/bg_logo.png'),
              ),
            ),
            const CircleAvatar(  //Logo of PSUT
              backgroundColor: Colors.white30,
              backgroundImage: AssetImage('assets/images/logo.png'),
              radius: 130.0,
            ),
            const SizedBox(height: 10.0),
            const Text('PSUT MyBus',
                style: TextStyle(
                  fontFamily: 'Wellfleet',
                  fontSize: 42.0,
                )
            ),
            const SizedBox(height: 20.0,),
            SizedBox( //Input Box of Bus Driver ID
              width: 350.0,
              height: 48.0,
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: "Student ID:",
                    labelStyle: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'Wellfleet',
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    )
                ),
              ),
            ),
            const SizedBox(height: 10.0), //Space between input boxes
            SizedBox( // Input Box of Password
              width: 350.0,
              height: 48.0,
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: "Password:",
                    labelStyle: const TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'Wellfleet',
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    )
                ),
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
                      MaterialPageRoute(builder: (context) => PSNavBar()),
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
                        borderRadius: BorderRadius.circular(40.0)
                    ),
                  ),
                  child: Text(
                    'Login',
                  )
              ),
            ),
            Container(
              height: 70.0,
              padding: const EdgeInsets.all(10.0),
              child: TextButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PSForget()),
                  );
                },
                child: const Text('Forget Password?',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Color.fromRGBO(11, 39, 143, 1.0),
                    fontSize: 16.0,
                    fontFamily: 'Wellfleet',
                  ),
                ),
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(width: 20.0),
                Image(image: AssetImage('assets/images/bg_logo2.png'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
