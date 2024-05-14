
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  CollectionReference users = FirebaseFirestore.instance.collection('students');
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
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
                        // return Text('First Name: ${data['firstName']}');
                        return Align(
                          alignment:Alignment.bottomCenter,
                          child: Container(
                            width: 300,
                            height: 200,
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
                                          padding: const EdgeInsets.all(4.0),
                                          height: innerHeight*0.70,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1.0,
                                                color: Colors.grey
                                            ),
                                            borderRadius: BorderRadius.circular(30),
                                            color: Colors.white,
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                      padding: const EdgeInsets.fromLTRB(8.0, 19.0, 8.0, 8.0),
                                                      child: const Column(
                                                        children: [
                                                          Text('Bus Admin Name',
                                                            style: TextStyle(
                                                              fontSize: 16.0,
                                                              fontFamily: 'Wellfleet',
                                                              fontWeight: FontWeight.bold,
                                                            ),),
                                                          Text('Mr.Omar Subaih',
                                                            style: TextStyle(
                                                                fontSize: 15.0,
                                                                fontFamily: 'Wellfleet'
                                                            ),),
                                                        ],
                                                      )
                                                  ),
                                                  Container(
                                                      padding: const EdgeInsets.fromLTRB(20.0, 19.0, 2.0, 8.0),
                                                      child: const Column(
                                                        children: [
                                                          Text('Arrival Time',
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
                                                      )
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                  alignment: Alignment.center,
                                                  padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 8.0),
                                                  child: const Column(
                                                    children: [
                                                      Text('Bus Admin Call',
                                                        style: TextStyle(
                                                          fontSize: 16.0,
                                                          fontFamily: 'Wellfleet',
                                                          fontWeight: FontWeight.bold,
                                                        ),),
                                                      Text('(06) 535 9949',
                                                        style: TextStyle(
                                                            fontSize: 15.0,
                                                            fontFamily: 'Wellfleet'
                                                        ),),
                                                    ],
                                                  )
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

  void onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }
}
