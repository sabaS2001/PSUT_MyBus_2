import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PSHomePage extends StatefulWidget {
  const PSHomePage({super.key});

  @override
  State<PSHomePage> createState() => _PSHomePageState();
}

class _PSHomePageState extends State<PSHomePage> {
  late GoogleMapController mapController;
  static const CameraPosition _initialLocation = CameraPosition(
      target: LatLng(32.02363463930013, 35.87613106096076), zoom: 13);

  Set<Marker> markers = {}; // Use a Set to avoid duplicate markers

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              size: 30.0,
              Icons.notifications_sharp,
              color: Color.fromRGBO(0, 169, 224, 1.0),
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
      body: StreamBuilder(
        //Get all the routes that's available in Madinah called Routes
        stream: FirebaseFirestore.instance.collection('markersAdmin').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
            child: CircularProgressIndicator(
              color: Colors.blue[900],
              strokeWidth: 3.0,
            ),
          );
          }
          markers.clear(); // Clear the markers before adding new ones
          for (var element in snapshot.data!.docs) {
            //For each document in the routes, retrieve their data
            final data = element.data();
            if (data['location'] != null) {
              // the marker id is the document title exists in the firestore
              final MarkerId markerId = MarkerId(element.id.toString());
              final Marker marker = Marker(
                markerId: markerId,
                //retrieve each marker's latitude and longitude from firestore
                position: LatLng(data['location'].latitude, data['location'].longitude),
                //display the marker title
                infoWindow: InfoWindow(title: element.id.toString()),
              );
              markers.add(marker);
            }
          }
          return GoogleMap(
            mapToolbarEnabled: false,
            initialCameraPosition: _initialLocation,
            onMapCreated: onMapCreated,
            markers: markers,
          );
        },
      ),
    );
  }

  void onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }
}

