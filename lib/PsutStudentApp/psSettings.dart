import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:psut_my_bus/PsutStudentApp/psLogin.dart';
import 'psBottomNavBar.dart';
import 'psProfile.dart';
import 'psChangePassword.dart';
import 'package:psut_my_bus/PsutStudentApp/psForgetPasswordSettings.dart';

class PSSettings extends StatefulWidget {
  const PSSettings({super.key});

  @override
  State<PSSettings> createState() => _PSSettingsState();
}

class _PSSettingsState extends State<PSSettings> {
  CollectionReference studentInfo =
      FirebaseFirestore.instance.collection('students');
  User? user = FirebaseAuth.instance.currentUser;
  double getScreenWidth(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: studentInfo.doc(user?.uid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data!.exists) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              // return Text('First Name: ${data['firstName']}');
              return SingleChildScrollView(
                child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    leading: Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PSNavBar()),
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
                  body: Container(
                    width: getScreenWidth(context),
                    height: MediaQuery.sizeOf(context).height,
                    margin: const EdgeInsets.symmetric(
                        vertical: 30.0, horizontal: 10.0),
                    alignment: Alignment.bottomRight,
                    child: Column(
                      children: [
                        const Text('Settings',
                            style: TextStyle(
                              fontFamily: 'Wellfleet',
                              fontSize: 30.0,
                            )),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // CircleAvatar(
                            //   // backgroundImage: data['imageLink'] != null && data['imageLink'].isNotEmpty && Uri.parse(data['imageLink']).isAbsolute
                            //   //     ? NetworkImage(data['imageLink'])
                            //   //     : const AssetImage('assets/images/logo.png'),
                            //   backgroundColor: Colors.blue.shade900,
                            //   radius: 40.0,
                            // ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data['firstName'] != null
                                      ? data['lastName'] != null
                                          ? '${data['firstName']} ${data['lastName']}'
                                          : '${data['firstName']} none'
                                      : 'none none',
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: 'Wellfleet',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  data['email'] ?? 'none',
                                  style: const TextStyle(
                                    fontSize: 13.0,
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
                            const SizedBox(width: 5.0),
                            const Text(
                              'Profile',
                              style: TextStyle(
                                fontFamily: 'Wellfleet',
                                fontSize: 15.0,
                              ),
                            ),
                            const SizedBox(width: 185.0),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PSProfile()),
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
                            Text('Security',
                                style: TextStyle(
                                  fontSize: 13.0,
                                  fontFamily: 'Wellfleet',
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 10.0,
                              height: 20.0,
                            ),
                            const Icon(
                              Icons.lock_outline_rounded,
                              size: 20.0,
                            ),
                            const SizedBox(width: 10.0),
                            const Text(
                              'Change Password',
                              style: TextStyle(
                                fontFamily: 'Wellfleet',
                                fontSize: 15.0,
                              ),
                            ),
                            const SizedBox(width: 100.0),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PSChangePassword()),
                                );
                              },
                              icon: const Icon(
                                Icons.arrow_forward_ios_sharp,
                                size: 15.0,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 10.0,
                              height: 20.0,
                            ),
                            const Icon(
                              Icons.lock_open_rounded,
                              size: 20.0,
                            ),
                            const SizedBox(width: 10.0),
                            const Text(
                              'Forget Password',
                              style: TextStyle(
                                fontFamily: 'Wellfleet',
                                fontSize: 15.0,
                              ),
                            ),
                            const SizedBox(width: 105.0),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PSForgetSettings()),
                                );
                              },
                              icon: const Icon(
                                Icons.arrow_forward_ios_sharp,
                                size: 15.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
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
                            SizedBox(
                              width: 10.0,
                              height: 20.0,
                            ),
                            Icon(
                              Icons.notifications_active_rounded,
                              size: 20.0,
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              'Bus Arrival Notification',
                              style: TextStyle(
                                fontFamily: 'Wellfleet',
                                fontSize: 15.0,
                              ),
                            ),
                            SizedBox(width: 50.0),
                            SwitchExample(),
                          ],
                        ),
                        const Row(
                          children: [
                            SizedBox(
                              width: 10.0,
                              height: 20.0,
                            ),
                            Icon(
                              Icons.notifications_active_rounded,
                              size: 20.0,
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              'Emergency Notification',
                              style: TextStyle(
                                fontFamily: 'Wellfleet',
                                fontSize: 15.0,
                              ),
                            ),
                            SizedBox(width: 50.0),
                            SwitchExample(),
                          ],
                        ),
                        const Row(
                          children: [
                            SizedBox(
                              width: 10.0,
                              height: 20.0,
                            ),
                            Icon(
                              Icons.notifications_active_rounded,
                              size: 20.0,
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              'Financial Notification',
                              style: TextStyle(
                                fontFamily: 'Wellfleet',
                                fontSize: 15.0,
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
                              width: 320.0,
                              height: 48.0,
                              child: ElevatedButton(
                                onPressed: () {
                                  FirebaseAuth.instance.signOut();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const PSLogin()));
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    side:
                                        BorderSide(color: Colors.blue.shade900),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                    )),
                                child: const Text('Log Out',
                                    style: TextStyle(
                                      fontSize: 20.0,
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
            return Padding(
              padding: const EdgeInsets.all(40.0),
              child: Center(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    strokeWidth: 4.0,
                    color: Colors.blue[900],
                  ),
                ),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(40.0),
            child: Center(
              child: SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(
                  strokeWidth: 4.0,
                  color: Colors.blue[900],
                ),
              ),
            ),
          );
        });
  }
}

class SwitchExample extends StatefulWidget {
  const SwitchExample({super.key});

  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {
  bool light0 = true;

  final WidgetStateProperty<Icon?> thumbIcon =
      WidgetStateProperty.resolveWith<Icon?>(
    (Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
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
