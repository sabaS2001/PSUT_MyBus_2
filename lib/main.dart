import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'BusDriverApp/bdBottomNavBar.dart';
import 'BusDriverApp/bdLogin.dart';
// import 'StartUpPsutMyBus.dart';
import 'BusDriverApp/bdHomePage.dart';
//this is a new version of psut_bus

void main() {
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    if (kReleaseMode) exit(1);
  };
  runApp(const MaterialApp(
    home: NavBar(),
  ));
}
