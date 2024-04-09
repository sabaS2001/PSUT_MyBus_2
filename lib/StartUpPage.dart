import 'package:flutter/material.dart';
import 'package:psut_my_bus/BusDriverApp/bdLogin.dart';

import 'PsutStudentApp/psStartUpPage.dart';

class StartUpPage extends StatelessWidget {
  const StartUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: const Image(
                image: AssetImage('assets/images/bg_logo.png'),
              ),
            ),
            Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
                alignment: const FractionalOffset(0, 0),
                child: const Center(
                  child: Center(
                    child: Text('Welcome to PSUT MyBus',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Wellfleet',
                          fontSize: 35.0,
                        )),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            const CircleAvatar(
              //Logo of PSUT
              backgroundColor: Colors.white30,
              backgroundImage: AssetImage('assets/images/logo.png'),
              radius: 130.0,
            ),
            const SizedBox(height: 30.0),
            SizedBox(
              width: 350.0,
              height: 65.0,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BDLogin()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(11, 39, 143, 1.0),
                    textStyle: const TextStyle(
                      fontSize: 22.0,
                      fontFamily: 'Wellfleet',
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0)),
                  ),
                  child: const Text(
                    'Bus Driver',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontFamily: 'Wellfleet',
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  )),
            ),
            const SizedBox(height: 30.0),
            SizedBox(
              width: 350.0,
              height: 65.0,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PSStartUp()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(11, 39, 143, 1.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0)),
                  ),
                  child: const Text(
                    'PSUT Student',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontFamily: 'Wellfleet',
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  )),
            ),
            const Padding(padding: EdgeInsets.symmetric(
                vertical: 60.0, horizontal: 0.0)),
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
