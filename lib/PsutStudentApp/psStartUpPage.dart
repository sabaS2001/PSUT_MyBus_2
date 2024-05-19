import 'package:flutter/material.dart';
import 'psLogin.dart';
import 'psSignUpPage.dart';
class PSStartUp extends StatelessWidget {
  const PSStartUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
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
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0)
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontFamily: 'Wellfleet',
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
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
                          MaterialPageRoute(builder: (context) => const PSSignUp()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(11, 39, 143, 1.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0)
                        ),
                      ),
                      child: const Text(
                        'New Account',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontFamily: 'Wellfleet',
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
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