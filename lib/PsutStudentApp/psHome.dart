import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'psBottomNavBar.dart';

class PSHomePage extends StatefulWidget {
  const PSHomePage({super.key});

  @override
  State<PSHomePage> createState() => _PSHomePage();
}

class _PSHomePage extends State<PSHomePage> {
  late GoogleMapController mapController;
  late String _mapStyle;
  static final CameraPosition _initialLocation = CameraPosition(
      target: LatLng(32.02363463930013, 35.87613106096076), zoom: 17);
  void initState() {
    super.initState();
    //loading map style JSON from asset file
    DefaultAssetBundle.of(context).loadString('mapTheme/map_style.mapTheme').then((string) {
      this._mapStyle = string;
    }).catchError((error) {
      log(error.toString());
    });
  }
  void onMapCreated(GoogleMapController controller) {
    //set style on the map on creation to customize look showing only map features
    //we want to show.
    log(this._mapStyle);
    setState(() {
      this.mapController = controller;
      if (_mapStyle != null) {
        this.mapController.setMapStyle(this._mapStyle).
        then((value) {
          log("Map Style set");
        }).catchError((error) =>
            log("Error setting map style:" + error.toString()));
      }
      else {
        log(
            "GoogleMapView:_onMapCreated: Map style could not be loaded.");
      }
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

