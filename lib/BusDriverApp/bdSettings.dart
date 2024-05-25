import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'bdBottomNavBar.dart';
import 'bdlogin.dart';
import 'bdprofile.dart';

//Bus Driver Settings Page
class BDSettings extends StatelessWidget {
  BDSettings({super.key});

  CollectionReference driverInfo = FirebaseFirestore.instance.collection('drivers');
  User? user = FirebaseAuth.instance.currentUser;

  double getScreenWidth(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth;
  }

  void releaseEmergency() async {
    FirebaseFirestore.instance.collection('Notifications').doc().set({
     'message': 'There has been an emergency! Please be paitent!',
      'time': Timestamp.now(),
    });
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: driverInfo.doc(user?.uid).get(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasData && snapshot.data!.exists){
              Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
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
                body: Container(
                  margin: const EdgeInsets.all(19.0),
                  height: MediaQuery.sizeOf(context).height,
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
                          CircleAvatar(
                            backgroundImage: data['imageLink'] != null
                                ? NetworkImage(data['imageLink'])
                                : const AssetImage('assets/images/logo.png'),
                            backgroundColor: Colors.blue[900],
                            radius: 40.0,
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (data['firstName'] ?? 'none') + ' ' +(data['lastName'] ?? 'none') ,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'Wellfleet',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                               Text(
                                data['email'] ?? 'none' ,
                                style: const TextStyle(
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
                                    builder: (context) => BDProfile()),
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
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 290.0,
                            height: 50.0,
                            child: ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      title: const Center(
                                        child: Text('Send An Emergency Notification',
                                          style: TextStyle(
                                              fontFamily: 'Wellfleet'
                                          ),),
                                      ),
                                      content: const Text('\tAre you sure you want to send the notification?',
                                        style: TextStyle(
                                            fontFamily: 'Wellfleet'
                                        ),),
                                      actions: <Widget>[
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            TextButton(
                                              style: ButtonStyle(
                                                backgroundColor: WidgetStatePropertyAll(Colors.blue.shade900),
                                              ),
                                              child: const Text('No', style: TextStyle(
                                                fontFamily: 'Wellfleet',
                                                color: Colors.white,
                                              ),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            TextButton(
                                              style: ButtonStyle(
                                                backgroundColor: WidgetStatePropertyAll(Colors.blue.shade900),
                                              ),
                                              child: const Text('Yes',
                                                style: TextStyle(
                                                  fontFamily: 'Wellfleet',
                                                  color: Colors.white,
                                                ),),
                                              onPressed: () {
                                                releaseEmergency();
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        ),

                                      ],
                                    );
                                  },
                                );
                                releaseEmergency();
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromRGBO(237, 23, 23, 1.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40.0),
                                  )),
                              child: const Text('EMERGENCY BUTTON',
                                style:  TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontFamily: 'Wellfleet',
                                  fontWeight: FontWeight.w500,
                                ),),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 235.0,
                            height: 37.0,
                            child: ElevatedButton(
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
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
                                    fontSize: 16.0,
                                    fontFamily: 'Wellfleet',
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(0, 169, 224, 1.0),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
            return  Padding(
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
