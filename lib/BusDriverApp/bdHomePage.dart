import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class BDHomePage extends StatefulWidget {
  const BDHomePage({super.key});

  @override
  State<BDHomePage> createState() => _BDHomePageState();
}

class _BDHomePageState extends State<BDHomePage> {

  late StreamSubscription<Position> _positionStreamSubscription;
  late Marker userMarker;

  final DateTime _currentTime = DateTime.now();
  late GoogleMapController mapController;
  static const CameraPosition _initialLocation = CameraPosition(
      target: LatLng(32.02363463930013, 35.87613106096076), zoom: 13);

  Set<Marker> markers = {}; // Use a Set to avoid duplicate markers

  CollectionReference users = FirebaseFirestore.instance.collection('drivers');
  User? user = FirebaseAuth.instance.currentUser;
  Future<void> _initLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location services are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location services are permanently denied');
    }

    _positionStreamSubscription = Geolocator.getPositionStream().listen((Position position) {
      _updateMarker(position);
    });
  }

  void _updateMarker(Position position) {
    setState(() {
      userMarker = Marker(
        markerId: userMarker.markerId,
        position: LatLng(position.latitude, position.longitude),
        infoWindow: userMarker.infoWindow,
      );
        });
  }
  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  @override
  void dispose() {
    _positionStreamSubscription.cancel();
    super.dispose();
  }
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
        stream:
        FirebaseFirestore.instance.collection('markersAdmin').snapshots(),
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
                position: LatLng(
                    data['location'].latitude, data['location'].longitude),
                //display the marker title
                infoWindow: InfoWindow(title: element.id.toString()),
              );
              markers.add(marker);
            }
          }
          return Stack(
            children: [
              GoogleMap(
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
                initialCameraPosition: _initialLocation,
                onMapCreated: onMapCreated,
                markers: markers,
              ),
              FutureBuilder(
                  future: users.doc(user?.uid).get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData && snapshot.data!.exists) {
                        Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;

                        return Align(
                          alignment:Alignment.bottomCenter,
                          child: Container(
                            width: 300,
                            height: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: LayoutBuilder(
                              builder: (context, constraints){
                                double innerHeight = constraints.maxHeight;
                                double innerWidth = constraints.maxWidth;
                                return Stack(
                                  children: [
                                    Positioned(
                                        bottom:10,
                                        left: 0,
                                        right: 0,
                                        child: Container(
                                          height: innerHeight *0.80,
                                          decoration: BoxDecoration(
                                border: Border.all(
                                                width: 1.0,
                                                color: Colors.grey
                                            ),
                                            borderRadius: BorderRadius.circular(30),
                                            color: Colors.white,
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    children: [
                                                      const Text('Driver Name',
                                                        style: TextStyle(
                                                          fontSize: 16.0,
                                                          fontFamily: 'Wellfleet',
                                                          fontWeight: FontWeight.bold,
                                                        ),),
                                                      Text(data['firstName'] + ' ' + data['lastName'],
                                                        style: const TextStyle(
                                                            fontSize: 15.0,
                                                            fontFamily: 'Wellfleet'
                                                        ),),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      const Text('Timer',
                                                        style: TextStyle(
                                                          fontSize: 16.0,
                                                          fontFamily: 'Wellfleet',
                                                          fontWeight: FontWeight.bold,
                                                        ),),
                                                      Text( DateFormat.jm().format(_currentTime).toString(),
                                                        style: const TextStyle(
                                                            fontSize: 15.0,
                                                            fontFamily: 'Wellfleet'
                                                        ),),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 110,
                                                    child: ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(30),
                                                              side: BorderSide(
                                                                color: Colors.blue.shade900,
                                                              )
                                                          ),
                                                          backgroundColor: Colors.white,
                                                        ),
                                                        onPressed: () {
                                                          _currentLocation().then((position) {
                                                            userMarker = Marker(
                                                              markerId: const MarkerId('current_location'),
                                                              position: LatLng(position.latitude, position.longitude),
                                                              infoWindow: const InfoWindow(title: 'Current Location'),
                                                            );
                                                            markers.add(userMarker);
                                                          });
                                                        },
                                                        child: const Text('Start',
                                                          style: TextStyle(
                                                            color: Color.fromRGBO(0, 169, 224, 1.0),
                                                            fontFamily: 'Wellfleet',
                                                            fontSize: 14.0,
                                                          ),)),
                                                  ),

                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  const Column(
                                                    children: [
                                                      Text('Bus Stop',
                                                        style: TextStyle(
                                                          fontSize: 16.0,
                                                          fontFamily: 'Wellfleet',
                                                          fontWeight: FontWeight.bold,
                                                        ),),
                                                      Text('Name',
                                                        style: TextStyle(
                                                            fontSize: 15.0,
                                                            fontFamily: 'Wellfleet'
                                                        ),),
                                                    ],
                                                  ),
                                                  const Column(
                                                    children: [
                                                      Text('Delivery Time',
                                                        style: TextStyle(
                                                          fontSize: 16.0,
                                                          fontFamily: 'Wellfleet',
                                                          fontWeight: FontWeight.bold,
                                                        ),),
                                                      Text('time',
                                                        style: TextStyle(
                                                            fontSize: 15.0,
                                                            fontFamily: 'Wellfleet'
                                                        ),),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 110,
                                                    child: ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(30),
                                                              side: BorderSide(
                                                                color: Colors.blue.shade900,
                                                              )
                                                          ),
                                                          backgroundColor: Colors.white,
                                                        ),
                                                        onPressed: () {},
                                                        child: const Text('Finish',
                                                          style: TextStyle(
                                                            color: Color.fromRGBO(0, 169, 224, 1.0),
                                                            fontFamily: 'Wellfleet',
                                                            fontSize: 14.0,
                                                          ),)),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        )),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        width: innerWidth * .22,
                                        height: innerWidth * .22,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              offset: const Offset(0, 1),
                                              blurRadius: 5,
                                              color: Colors.black.withOpacity(0.3),
                                            ),
                                          ],
                                          borderRadius: BorderRadius.circular(70),
                                          color: Colors.white,
                                        ),
                                        child: Center(
                                          child: Text(data['busNumber'],
                                            style: const TextStyle(
                                                fontSize: 40.0,
                                                fontFamily: 'Wellfleet'
                                            ),),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                        );
                      }
                      return Text('${user?.uid}');
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue[900],
                        strokeWidth: 3.0,
                      ),
                    );
                  })
            ],
          );
        },
      ),
    );
  }


  Future <Position> _currentLocation() async {
   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
   if(!serviceEnabled){
     return Future.error('Location services are disabled');
   }
   LocationPermission permission = await Geolocator.checkPermission();
   if (permission == LocationPermission.denied){
     permission = await Geolocator.requestPermission();
     if(permission == LocationPermission.denied){
       return Future.error('Location services are denied');
     }
     if(permission == LocationPermission.deniedForever){
       return Future.error('Location services are permanently denied');
     }
   }
   return await Geolocator.getCurrentPosition();
  }
  void onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }
}



