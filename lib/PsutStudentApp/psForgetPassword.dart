import 'package:flutter/material.dart';
import 'psLogin.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PSForget extends StatefulWidget {
  const PSForget({super.key});

  @override
  State<PSForget> createState() => _PSForgetState();
}

class _PSForgetState extends State<PSForget> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

//Regression Expression for Student Email
  bool isEmailValid(String email) {
    const pattern = r'^[a-zA-Z]{3}\d{8}@std.psut.edu.jo$';
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(email);
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
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
                  MaterialPageRoute(builder: (context) => const PSLogin()),
                );
              },
              icon: const Icon(
                Icons.arrow_circle_left_outlined,
                size: 40.0,
              ),
              color: Colors.blue[900],
            ),
          ),
          title: const Center(
            child: SizedBox(
              width: 190.0,
              child: Text(
                'Forget Password',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'Wellfleet',
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 50.0,
              ),
              Container(
                height: 150.0,
                alignment: Alignment.topLeft,
                child: const Image(
                  image: AssetImage('assets/images/bg_logo.png'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 380.0,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          validator: (psEmail) {
                            if (isEmailValid(psEmail!)) {
                              return null;
                            } else {
                              return 'Invalid Student Email!';
                            }
                          },
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.fromLTRB(
                                  10.0, 0.0, 15.0, 0.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.black)),
                              labelText: "Student Email:",
                              labelStyle: const TextStyle(
                                fontSize: 15.0,
                                fontFamily: 'Wellfleet',
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              )),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const SizedBox(
                          width: 370.0,
                          height: 70.0,
                          child: Text(
                              'Enters the email address you used to register with Dynamic Layers. You will receive an email to define a new password.'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: 320.0,
                height: 48.0,
                child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          await FirebaseAuth.instance.sendPasswordResetEmail(
                              email: _emailController.text.trim());
                          _showAlertDialog(context);
                          MaterialPageRoute(builder: (context) => const PSLogin());
                        } on FirebaseAuthException catch (e) {
                          throw Exception(e.message.toString());
                        } catch (e) {
                          throw Exception(e.toString());
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(11, 39, 143, 1.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0)),
                    ),
                    child: const Text(
                      'SUBMIT',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Wellfleet',
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    )),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 20.0,
                    height: 500.0,
                  ),
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

void _showAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shadowColor: Colors.blue[900],
        backgroundColor: Colors.white,
        title: const Center(
          child:  Text('Forget Password',
              style: TextStyle(
                fontFamily: 'Wellfleet',
                fontSize: 20.0,
                color: Colors.black,
              )),
        ),
        content: const Text('Please Check Your Email to Reset Your Password!',
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontFamily: 'Wellfleet',
              fontSize: 16.0,
              color: Colors.black,
            )),
        actions:  <Widget>[
          Center(
            child: ElevatedButton(
              child: const Text('OK',
                  style: TextStyle(
                    fontFamily: 'Wellfleet',
                    fontSize: 15.0,
                    color: Colors.black,
                  )),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      );
    },
  );
}
