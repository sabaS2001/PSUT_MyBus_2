import 'dart:ui';
import 'package:flutter/material.dart';
import 'psSettings.dart';
class PSChangePassword extends StatelessWidget {
  const PSChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.all(11.0),
          child: IconButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PSSettings()),
              );
            },
            icon: const Icon(Icons.arrow_circle_left_outlined, size: 40.0,),
            color: Colors.blue[900],
          ),
        ),
        title: const Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(50.0,30.0,10.0,0.0),
            child: SizedBox(
              width: 290.0,
              child: Text('Change Password',
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontFamily: 'Wellfleet',
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 30.0,),
          Row(
            children: [
              Container(
                height: 100.0,
                alignment: Alignment.topLeft,
                child: Image(
                  image: const AssetImage('assets/images/bg_logo.png'),
                ),
              ),
              const SizedBox(width: 20.0,),
              SizedBox(
                width: 320.0,
                height: 50.0,
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.black)
                      ),
                      labelText: "Email:",
                      labelStyle: const TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'Wellfleet',
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      )
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
            child: SizedBox(
              width: 305.0,
              height: 70.0,
              child: Text(
                  'The new password must be different from the current password. '
              ),
            ),
          ),
          SizedBox(
            width: 320.0,
            height: 50.0,
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.black)
                  ),
                  labelText: "Confirmed Password:",
                  labelStyle: const TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'Wellfleet',
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  )
              ),
            ),
          ),
          const SizedBox(height: 30.0,),
          SizedBox(
            width: 320.0,
            height: 48.0,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PSSettings()),
                  );
                },
                child: const Text(
                  'SUBMIT',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(11, 39, 143, 1.0),
                  textStyle: const TextStyle(
                    fontSize: 20.0,
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
        ],
      ),
    );
  }
}
