import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:psut_my_bus/PsutStudentApp/psBottomNavBar.dart';
import 'package:psut_my_bus/PsutStudentApp/psLogin.dart';



//Authentication Page for PSUT App

class Authpage extends StatelessWidget {
  const Authpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return const PSNavBar();
          }
          else{
            return const PSLogin();
          }
        },
      ),
    );
  }
}
