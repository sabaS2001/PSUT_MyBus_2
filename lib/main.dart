import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:psut_my_bus/PsutStudentApp/psBottomNavBar.dart';
import 'package:psut_my_bus/firebase_options.dart';
import 'PsutStudentApp/psHome.dart';

// import 'StartUpPsutMyBus.dart';
//this is a new version of psut_bus

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    if (kReleaseMode) exit(1);
  };
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PSNavBar(),
  ));
}
