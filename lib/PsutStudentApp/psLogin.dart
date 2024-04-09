import 'package:flutter/material.dart';
import 'psForgetPassword.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PSLogin extends StatefulWidget{
  const PSLogin({super.key});

  @override
  State<PSLogin> createState() => _PSLoginState();
}

class _PSLoginState extends State<PSLogin> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

//Regression Expression: making the student enters the correct email format and password format
  bool isPasswordValid(String password) {
    if (password.length == 8) {
      return true;
    } else {
      return false;
    }
  }

  bool isEmailValid(String email) {
    const pattern = r'^[a-zA-Z]{3}\d{8}@std.psut.edu.jo$'; //^[a-zA-Z]{3}
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(email);
  }

  // sign user in method
  void signUserIn() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // // pop the loading circle
      if(!mounted) return;
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      if(!mounted) return;
      Navigator.pop(context);
        // WRONG EMAIL
        if (e.code == 'user-not-found') {
          // show error to user
         print('Wrong Email');
        }

        // WRONG PASSWORD
        else if (e.code == 'wrong-password') {
          // show error to user
          print('Wrong Password');
        }
      }
  }



  @override
    Widget build(BuildContext context) {
      return Form(
        key: _formKey,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: const Image(
                    image: AssetImage('assets/images/bg_logo.png'),
                  ),
                ),
                const CircleAvatar( //Logo of PSUT
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
                  child: TextFormField(
                    controller: _emailController,
                    validator: (psEmail) {
                      if (isEmailValid(psEmail!)) {
                        return null;
                      } else {
                        return 'Invalid Student Email!';
                      }
                    },
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        errorStyle: TextStyle(
                          color: Colors.red[900],
                          fontSize: 16.0,
                          fontFamily: 'Wellfleet',
                        ),
                        labelText: "Student Email:",
                        labelStyle: const TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Wellfleet',
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        )
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                //Space between input boxes
                SizedBox( // Input Box of Password
                  width: 350.0,
                  child: TextFormField(
                    controller: _passwordController,
                    validator: (psPassword) {
                      if (isPasswordValid(psPassword!)) {
                        return null;
                      } else {
                        return 'Invalid Password!';
                      }
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        errorStyle: TextStyle(
                          color: Colors.red[900],
                          fontSize: 16.0,
                          fontFamily: 'Wellfleet',
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
                const SizedBox(height: 20.0),
                //Space between input box and the button
                SizedBox(
                  width: 320.0,
                  height: 48.0,
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          signUserIn();
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => const PSNavBar()),
                          // );
                        }

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
                          fontSize: 20.0,
                          fontFamily: 'Wellfleet',
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      )
                  ),
                ),
                Container(
                  height: 70.0,
                  padding: const EdgeInsets.all(10.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (
                            context) => const PSForget()),
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
                const Padding(padding: EdgeInsets.symmetric(
                    vertical: 90.0, horizontal: 0.0)),
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
        ),
      );
    }
  }
