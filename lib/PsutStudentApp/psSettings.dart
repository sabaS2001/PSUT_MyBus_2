import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'psHome.dart';
import 'psBottomNavBar.dart';
import 'psProfile.dart';
import 'psChangePassword.dart';
import 'package:psut_my_bus/PsutStudentApp/psForgetPasswordSettings.dart';
import 'package:psut_my_bus/PsutStudentApp/psLogin.dart';



class PSSettings extends StatelessWidget {
  const PSSettings({super.key});
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
                MaterialPageRoute(builder: (context) => PSNavBar()),
              );
            },
            icon: const Icon(Icons.arrow_circle_left_outlined, size: 40.0,),
            color: Colors.blue[900],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 50.0),
          alignment: Alignment.bottomRight,
          child: Column(
            children: [
              Container(
                child: const Text('Settings',
                    style: TextStyle(
                      fontFamily: 'Wellfleet',
                      fontSize: 30.0,
                    )),
              ),
              const SizedBox(height: 20.0),
              const Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/logo.png'),
                    backgroundColor: Colors.transparent,
                    radius: 40.0,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PSUT Student Name',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Wellfleet',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20.0,),
                      Text(
                        'Student Email',
                        style: TextStyle(
                          fontSize: 10.0,
                          fontFamily: 'Wellfleet',
                        ),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 10.0,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Personal Info',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'Wellfleet',
                      )),
                ],
              ),
               Row(
                children: [
                  const SizedBox(width: 10.0, height: 40.0,),
                  const Icon(Icons.person_outline_rounded,
                    size: 20.0,),
                  const SizedBox(width: 10.0),
                  const Text('Profile',
                    style: TextStyle(
                      fontFamily: 'Wellfleet',
                      fontSize: 13.0,
                    ),
                  ),
                  const SizedBox(width: 160.0),
                  IconButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PSProfile()),
                      );
                    },
                    icon: const Icon(Icons.arrow_forward_ios_sharp,
                      size: 15.0,),
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Security',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'Wellfleet',
                      )),
                ],
              ),
              const SizedBox(height: 5.0,),
               Row(
                children: [
                  const SizedBox(width: 10.0, height: 20.0,),
                  const Icon(Icons.lock_outline_rounded,
                    size: 20.0,),
                  const SizedBox(width: 10.0),
                  const Text('Change Password',
                    style: TextStyle(
                      fontFamily: 'Wellfleet',
                      fontSize: 13.0,
                    ),
                  ),
                  const SizedBox(width: 100.0),
                  IconButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PSChangePassword()),
                      );
                    },
                    icon: const Icon(Icons.arrow_forward_ios_sharp,
                      size: 15.0,),
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(width: 10.0, height: 20.0,),
                  const Icon(Icons.lock_open_rounded,
                    size: 20.0,),
                  const SizedBox(width: 10.0),
                  const Text('Forget Password',
                    style: TextStyle(
                      fontFamily: 'Wellfleet',
                      fontSize: 13.0,
                    ),
                  ),
                  const SizedBox(width: 105.0),
                  IconButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const psForgetSettings()),
                      );
                    },
                    icon: const Icon(Icons.arrow_forward_ios_sharp,
                      size: 15.0,),
                  ),
                ],
              ),
              const SizedBox(height: 10.0,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Notifications',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'Wellfleet',
                      )),
                ],
              ),
              const Row(
                children: [
                  SizedBox(width: 10.0, height: 20.0,),
                  Icon(Icons.notifications_active_rounded,
                    size: 20.0,),
                  SizedBox(width: 10.0),
                  Text('Bus Arrival Notification',
                    style: TextStyle(
                      fontFamily: 'Wellfleet',
                      fontSize: 13.0,
                    ),
                  ),
                  SizedBox(width: 50.0),
                  SwitchExample(),
                ],
              ),
              const Row(
                children: [
                  SizedBox(width: 10.0, height: 20.0,),
                  Icon(Icons.notifications_active_rounded,
                    size: 20.0,),
                  SizedBox(width: 10.0),
                  Text('Emergency Notification',
                    style: TextStyle(
                      fontFamily: 'Wellfleet',
                      fontSize: 13.0,
                    ),
                  ),
                  SizedBox(width: 50.0),
                  SwitchExample(),
                ],
              ),
              const Row(
                children: [
                  SizedBox(width: 10.0, height: 20.0,),
                  Icon(Icons.notifications_active_rounded,
                    size: 20.0,),
                  SizedBox(width: 10.0),
                  Text('Financial Notification',
                    style: TextStyle(
                      fontFamily: 'Wellfleet',
                      fontSize: 13.0,
                    ),
                  ),
                  SizedBox(width: 60.0),
                  SwitchExample(),
                ],
              ),
              const SizedBox(height: 40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 225.0,
                    height: 37.0,
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const psLogin()),
                        );
                      },
                      child: Text('Log Out',
                          style: const TextStyle(
                            fontSize: 13.0,
                            fontFamily: 'Wellfleet',
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(0, 169, 224, 1.0),
                          )),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: BorderSide(
                              color: Colors.blue.shade900
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          )
                      ),
                    ),
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
class SwitchExample extends StatefulWidget {
  const SwitchExample({super.key});

  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {
  bool light0 = true;

  final MaterialStateProperty<Icon?> thumbIcon =
  MaterialStateProperty.resolveWith<Icon?>(
        (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Switch(
          value: light0,
          onChanged: (bool value) {
            setState(() {
              light0 = value;
            });
          },
        ),
      ],
    );
  }
}
