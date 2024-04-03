import 'package:flutter/material.dart';
import 'psLogin.dart';
class PSStartUp extends StatelessWidget {
  const PSStartUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 600.0,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(  //Logo of PSUT
                  backgroundColor: Colors.white30,
                  backgroundImage: AssetImage('assets/images/logo.png'),
                  radius: 130.0,
                ),
                const SizedBox(height: 30.0),
                Container(
                  width: 270.0,
                  alignment: const FractionalOffset(0,0),
                  child: const Center(
                    child: Text('PSUT MyBus',
                        style: TextStyle(
                          fontFamily: 'Wellfleet',
                          fontSize: 40.0,
                        )
                    ),
                  ),
                ),
                const SizedBox(height: 60.0),
                SizedBox(
                  width: 350.0,
                  height: 65.0,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PSLogin()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(11, 39, 143, 1.0),
                        textStyle: const TextStyle(
                          fontSize: 22.0,
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
                const SizedBox(height: 20.0),
                SizedBox(
                  width: 350.0,
                  height: 65.0,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PSLogin()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(11, 39, 143, 1.0),
                        textStyle: const  TextStyle(
                          fontSize: 22.0,
                          fontFamily: 'Wellfleet',
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0)
                        ),
                      ),
                      child: const Text(
                        'New Account',
                      )
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}