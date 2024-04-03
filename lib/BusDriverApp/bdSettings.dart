import 'package:flutter/material.dart';
import 'bdBottomNavBar.dart';
import 'bdlogin.dart';
import 'bdprofile.dart';

//Bus Driver Settings Page
class BDSettings extends StatelessWidget {
  const BDSettings({super.key});
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NavBar()),
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
                    backgroundImage: AssetImage('images/logo.png'),
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
                        'Bus Driver Name',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Wellfleet',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'Bus Driver Email',
                        style: TextStyle(
                          fontSize: 10.0,
                          fontFamily: 'Wellfleet',
                        ),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
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
                  const SizedBox(
                    width: 10.0,
                    height: 40.0,
                  ),
                  const Icon(
                    Icons.person_outline_rounded,
                    size: 20.0,
                  ),
                  const SizedBox(width: 10.0),
                  const Text(
                    'Profile',
                    style: TextStyle(
                      fontFamily: 'Wellfleet',
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(width: 160.0),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BDProfile()),
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios_sharp,
                      size: 15.0,
                    ),
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Emergency',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'Wellfleet',
                      )),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 245.0,
                    height: 37.0,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(237, 23, 23, 1.0),
                          textStyle: const TextStyle(
                            fontSize: 14.0,
                            fontFamily: 'Wellfleet',
                            fontWeight: FontWeight.w500,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          )),
                      child: const Text('EMERGENCY BUTTON'),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 225.0,
                    height: 37.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BDLogin()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: BorderSide(color: Colors.blue.shade900),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          )),
                      child: const Text('Log Out',
                          style: TextStyle(
                            fontSize: 13.0,
                            fontFamily: 'Wellfleet',
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(0, 169, 224, 1.0),
                          )),
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
