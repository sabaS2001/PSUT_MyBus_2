import 'package:flutter/material.dart';
import 'package:psut_my_bus/PsutStudentApp/psStartUpPage.dart';
import 'psLogin.dart';

class PSSignUp extends StatelessWidget with InputValidationPSProfileMixin{
  PSSignUp({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  Form (
      key: _formKey,
      child: Scaffold(
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
                  MaterialPageRoute(builder: (context) => const PSStartUp()),
                );
              },
              icon: const Icon(Icons.arrow_circle_left_outlined, size: 40.0,),
              color: Colors.blue[900],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child: Text('Sign Up',
                    style: TextStyle(
                      fontFamily: 'Wellfleet',
                      fontSize: 30.0,
                    )),
              ),
              const SizedBox(height: 20.0,),
              const SizedBox(height: 40.0,),
              Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(width: 20.0, height: 250.0,),
                      Image(image: AssetImage('assets/images/Roundel.png'))
                    ],
                  ),

                  SizedBox(
                    width: 340.0,
                    child: TextFormField(
                      validator: (fName) {
                        if (isNameValid(fName!)) {
                          return null;
                        } else {
                          return 'Invalid First Name!';
                        }
                      },
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(color: Colors.black)
                          ),
                          labelText: "First Name:",
                          labelStyle: const TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'Wellfleet',
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          )
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0,),
                  SizedBox(
                    width: 340.0,
                    child: TextFormField(
                      validator: (lName) {
                        if (isNameValid(lName!)) {
                          return null;
                        } else {
                          return 'Invalid Last Name!';
                        }
                      },
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(color: Colors.black)
                          ),
                          labelText: "Last Name:",
                          labelStyle: const TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'Wellfleet',
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          )
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0,),
                  SizedBox(
                    width: 340.0,
                    child: TextFormField(
                      validator: (psID) {
                        if (isIDValid(psID!)) {
                          return null;
                        } else {
                          return 'Invalid Student ID!';
                        }
                      },
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(color: Colors.black)
                          ),
                          labelText: "Student ID Number:",
                          labelStyle: const TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'Wellfleet',
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          )
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0,),
                  SizedBox(
                    width: 335.0,
                    child: Text(
                      textAlign: TextAlign.justify,
                      'Make sure it matches the name on your student ID.',
                      style: TextStyle(
                        fontFamily: 'Wellfleet',
                        fontSize: 12.0,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0,),
                  SizedBox(
                    width: 340.0,
                    child: TextFormField(
                      validator: (psEmail) {
                        if (isEmailValid(psEmail!)) {
                          return null;
                        } else {
                          return 'Invalid University Email!';
                        }
                      },
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:const BorderSide(color: Colors.black)
                          ),
                          labelText: "University Email:",
                          labelStyle: const TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'Wellfleet',
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          )
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0,),
                   SizedBox(
                    width: 335.0,
                    child: Text(
                      textAlign: TextAlign.justify,
                        'We will email you any important notifications regarding to the bus.',
                        style: TextStyle(
                          fontFamily: 'Wellfleet',
                          fontSize: 12.0,
                          color: Colors.grey[600],
                        ),
                    ),
                  ),
                  const SizedBox(height: 20.0,),
                  SizedBox(
                    width: 340.0,
                    child: TextFormField(
                      validator: (lName) {
                        if (isNameValid(lName!)) {
                          return null;
                        } else {
                          return 'Invalid Password!';
                        }
                      },
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(color: Colors.black)
                          ),
                          labelText: "Password:",
                          labelStyle: const TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'Wellfleet',
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          )
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0,),
                  SizedBox(
                    width: 340.0,
                    child: TextFormField(
                      validator: (lName) {
                        if (isNameValid(lName!)) {
                          return null;
                        } else {
                          return 'Invalid Confirmed Password!';
                        }
                      },
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
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
                  const SizedBox(height:50.0),
                  SizedBox(
                    width: 340.0,
                    height: 50.0,
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
                          'Agree & Continue',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontFamily: 'Wellfleet',
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        )
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(width: 20.0, height: 250.0,),
                      Image(image: AssetImage('assets/images/bg_logo2.png'))
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

mixin InputValidationPSProfileMixin {
  //regression expression for first name and last name
  bool isNameValid(String name){
    const pattern = r'^[a-zA-Z]+$';
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(name);
  }
  //regression expression for psut student id
  bool isIDValid(String bdId) {
    const pattern = r'^\d+$';
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(bdId) && bdId.length == 8;
  }
  //regression expression for psut student email
  bool isEmailValid(String email){
    const pattern = r'^\d{8}@std.psut.edu.jo$';
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(email);
  }

}