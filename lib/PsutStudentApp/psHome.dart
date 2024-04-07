import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PSHomePage extends StatefulWidget {
  const PSHomePage({super.key});

  @override
  State<PSHomePage> createState() => _PSHomePage();
}

class _PSHomePage extends State<PSHomePage> {
  late GoogleMapController mapController;
  static const CameraPosition _initialLocation = CameraPosition(
       target: LatLng(32.02363463930013, 35.87613106096076), zoom: 17);
  @override
  void initState() {
    super.initState();
  }
  void onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GoogleMap(
          initialCameraPosition: _initialLocation,
          onMapCreated: onMapCreated,
        ),
      ),
    );
  }
}

