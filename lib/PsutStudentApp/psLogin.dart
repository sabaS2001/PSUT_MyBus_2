import 'dart:ui';
import 'package:flutter/material.dart';
import 'psForgetPassword.dart';
import 'psBottomNavBar.dart';
import 'dart:io';


class psLogin extends StatelessWidget {
  const psLogin({super.key});

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
              child: Image(
                image:AssetImage('assets/images/bg_logo.png'),
              ),
            ),
            CircleAvatar(  //Logo of PSUT
              backgroundColor: Colors.white30,
              backgroundImage: AssetImage('assets/images/logo.png'),
              radius: 130.0,
            ),
            SizedBox(height: 10.0),
            Text('PSUT MyBus',
                style: TextStyle(
                  fontFamily: 'Wellfleet',
                  fontSize: 42.0,
                )
            ),
            SizedBox(height: 20.0,),
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
            SizedBox(height: 10.0), //Space between input boxes
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
                    labelStyle: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'Wellfleet',
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    )
                ),
              ),
            ),
            SizedBox(height: 20.0), //Space between input box and the button
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
                  child: Text(
                    'Login',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(11, 39, 143, 1.0),
                    textStyle: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'Wellfleet',
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0)
                    ),
                  )
              ),
            ),
            Container(
              height: 70.0,
              padding: EdgeInsets.all(10.0),
              child: TextButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => psForget()),
                  );
                },
                child: Text('Forget Password?',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Color.fromRGBO(11, 39, 143, 1.0),
                    fontSize: 16.0,
                    fontFamily: 'Wellfleet',
                  ),
                ),
              ),
            ),
            Row(
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
