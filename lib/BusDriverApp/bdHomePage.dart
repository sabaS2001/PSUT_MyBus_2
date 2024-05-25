import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:psut_my_bus/BusDriverApp/bdNotification.dart';

int index = 0;

class BDHomePage extends StatefulWidget {
  const BDHomePage({super.key});

  @override
  State<BDHomePage> createState() => _BDHomePageState();
}

class _BDHomePageState extends State<BDHomePage> {
  late DateTime currentTime = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    DateTime.now().hour,
    DateTime.now().minute,
  );
 late String _currentTime = "";
  late Timestamp t;
  late GoogleMapController mapController;
  final Completer <GoogleMapController> _controller = Completer();
  BitmapDescriptor BusUserIcon = BitmapDescriptor.defaultMarker;
  List<Marker> markers = [];
  List<DateTime> times = [];
  late String arrivalTime = 'No Buses At this Time'; // Use a Set to avoid duplicate markers
  CollectionReference users = FirebaseFirestore.instance.collection('drivers');
  User? user = FirebaseAuth.instance.currentUser;
  late CollectionReference<Object?>? busScheduleCollection = FirebaseFirestore
      .instance
      .collection('markers')
      .doc('Tabarbour')
      .collection('Routes'); // return null if the document does not exist;
  String busLine = '';
  String busStopName = 'No Buses!';


  //to enable the current location in database
  void enableUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    FirebaseFirestore.instance.collection('drivers').doc(user?.uid).update({
      'latitude': 0.0,
      'longitude': 0.0,
      'timestamp': Timestamp.fromDate(DateTime.now()),
    });
  }



  //save the current location in database
  void saveUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    FirebaseFirestore.instance.collection('drivers').doc(user?.uid).update({
      'latitude': position.latitude,
      'longitude': position.longitude,
      'timestamp': Timestamp.fromDate(DateTime.now()),
    });
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are permanently denied, we cannot request permissions.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
  // Add a new Marker widget to the markers list for the current user location
  Future<void> _addCurrentLocationMarker() async {
    Position position = await _getCurrentLocation();
    setState(() {
      markers.add(
        Marker(
          markerId: const MarkerId('currentLocation'),
          position: LatLng(position.latitude, position.longitude),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
      saveUserLocation();
    });
  }

  // Assigning the markers based on the bus line the admin assigned
  Future<CollectionReference<Object?>?> readData() async {
    User? user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('drivers')
        .doc(user?.uid)
        .get();
    if (documentSnapshot.exists) {
      busLine = documentSnapshot.get('busLine');
      debugPrint(busLine);
      if (busLine == 'Marj Al Hammam') {
        return FirebaseFirestore.instance
            .collection('markers')
            .doc('Marj Al Hammam')
            .collection('Routes2');
      } else if (busLine == 'Madinah ') {
        return FirebaseFirestore.instance
            .collection('markers')
            .doc('Madinah ')
            .collection('Routes');
      }
    } else {
      debugPrint('Document does not exist');
    }
    return null;
  }

  Future<void> _initBusScheduleCollection() async {
    busScheduleCollection = await readData();
    setState(() {});
  }

  //Polylines; connect a line between 2 markers
  List<LatLng> polylineCoordinates = [];

  void getPolyPoints(index) async {
    if (markers.length < 2) return; // return if there are less than 2 markers

    LatLng sourceLocation = LatLng(
        markers[index].position.latitude, markers[index].position.longitude);
    LatLng destinationLocation = LatLng(markers[index + 1].position.latitude,
        markers[index + 1].position.longitude);

    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyB6fVHZJJyDZUc4DNSreEZUy6tacqEqeQ0',
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    _initBusScheduleCollection();
    _addCurrentLocationMarker();
    saveUserLocation();
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BDNotification()),
              );

            },
          )
        ],
      ),
      body: StreamBuilder(
              //Get all the routes that's available in Madinah called Routes
              stream: busScheduleCollection!.orderBy('number', descending: false).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue[900],
                      strokeWidth: 3.0,
                    ),
                  );
                }
                times.clear();
                markers.clear();
                for (var element in snapshot.data!.docs) {
                  //For each document in the routes, retrieve their data
                  final data = element.data();
                  if ((data as Map<String, dynamic>)['location']?.latitude !=
                      null) {
                    t = data['time'] ?? Timestamp.fromDate(DateTime.now());
                    // the marker id is the document title exists in the firestore
                    final MarkerId markerId = MarkerId(element.id.toString());
                    final Marker marker = Marker(
                      markerId: markerId,
                      //retrieve each marker's latitude and longitude from firestore
                      position: LatLng(data['location']?.latitude,
                          data['location']?.longitude),
                      //display the marker title
                      infoWindow: InfoWindow(title: element.id.toString()),
                    );
                    markers.add(marker);
                    times.add(t.toDate());
                  }
                }
                return Stack(
                  children: [
                    GoogleMap(
                      zoomControlsEnabled: false,
                      mapToolbarEnabled: false,
                      myLocationEnabled: true,
                      initialCameraPosition: const CameraPosition(
                          target: LatLng(32.023757505069405, 35.876136445246374), zoom: 13),
                      onMapCreated: (mapController){
                        _controller.complete(mapController);
                      },
                      markers: markers.toSet(),
                      polylines: {
                        Polyline(
                            polylineId: const PolylineId('route'),
                            points: polylineCoordinates,
                            color: const Color.fromRGBO(0, 169, 224, 1.0))
                      },
                    ),
                    FutureBuilder(
                        future: users.doc(user?.uid).get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasData && snapshot.data!.exists) {
                              Map<String, dynamic> data =
                                  snapshot.data!.data() as Map<String, dynamic>;

                              return Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  width: 350,
                                  height: 300,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      double innerHeight =
                                          constraints.maxHeight;
                                      double innerWidth = constraints.maxWidth;
                                      return Stack(
                                        children: [
                                          Positioned(
                                              bottom: 10,
                                              left: 0,
                                              right: 0,
                                              child: Container(
                                                height: innerHeight * 0.80,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1.0,
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: Colors.white,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            const Text(
                                                              'Driver Name',
                                                              style: TextStyle(
                                                                fontSize: 16.0,
                                                                fontFamily:
                                                                    'Wellfleet',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            Text(
                                                              data['firstName'] !=
                                                                      null
                                                                  ? data['lastName'] !=
                                                                          null
                                                                      ? '${data['firstName']} ${data['lastName']}'
                                                                      : '${data['firstName']} none'
                                                                  : 'none none',
                                                              style: const TextStyle(
                                                                  fontSize:
                                                                      15.0,
                                                                  fontFamily:
                                                                      'Wellfleet'),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          children: [
                                                            const Text(
                                                              'Timer',
                                                              style: TextStyle(
                                                                fontSize: 16.0,
                                                                fontFamily:
                                                                    'Wellfleet',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            Text(
                                                                _currentTime = DateFormat.jm()
                                                                  .format(
                                                                      currentTime)
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  fontSize:
                                                                      15.0,
                                                                  fontFamily:
                                                                      'Wellfleet'),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          width: 110,
                                                          child: ElevatedButton(
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                30),
                                                                        side:
                                                                            BorderSide(
                                                                          color: Colors
                                                                              .blue
                                                                              .shade900,
                                                                        )),
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
                                                              ),
                                                              onPressed: () {
                                                                  showDialog(
                                                                    context: context,
                                                                    builder: (BuildContext context) {
                                                                      return AlertDialog(
                                                                        backgroundColor: Colors.white,
                                                                        title: const Center(
                                                                          child: Text('Start A Route',
                                                                          style: TextStyle(
                                                                            fontFamily: 'Wellfleet'
                                                                          ),),
                                                                        ),
                                                                        content: const Text('\tAre you sure you want to start the route?',
                                                                          style: TextStyle(
                                                                              fontFamily: 'Wellfleet'
                                                                          ),),
                                                                        actions: <Widget>[
                                                                          Row(
                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                            children: [
                                                                              TextButton(
                                                                                style: ButtonStyle(
                                                                                  backgroundColor: WidgetStatePropertyAll(Colors.blue.shade900),
                                                                                ),
                                                                                child: const Text('No', style: TextStyle(
                                                                                    fontFamily: 'Wellfleet',
                                                                                    color: Colors.white,
                                                                                ),
                                                                                ),
                                                                                onPressed: () {
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                              ),
                                                                              TextButton(
                                                                                style: ButtonStyle(
                                                                                  backgroundColor: WidgetStatePropertyAll(Colors.blue.shade900),
                                                                                ),
                                                                                child: const Text('Yes',
                                                                                  style: TextStyle(
                                                                                      fontFamily: 'Wellfleet',
                                                                                    color: Colors.white,
                                                                                  ),),
                                                                                onPressed: () {
                                                                                  if (markers
                                                                                      .isNotEmpty) {
                                                                                    busStopName = markers[
                                                                                    index+1]
                                                                                        .markerId
                                                                                        .value;
                                                                                  }
                                                                                  final now = TimeOfDay.now();
                                                                                  final amOrPm = now.hour < 12 ? arrivalTime = (currentTime.hour - -times[index].hour).toString() : ((currentTime.hour) - times[index].hour).toString();
                                                                                  arrivalTime = '$amOrPm hrs';
                                                                                  polylineCoordinates.clear();
                                                                                  getPolyPoints(
                                                                                      index++);
                                                                                  _getCurrentLocation();
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                              ),
                                                                            ],
                                                                          ),

                                                                        ],
                                                                      );
                                                                    },
                                                                  );
                                                              },
                                                              child: const Text(
                                                                'Start',
                                                                style:
                                                                    TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          0,
                                                                          169,
                                                                          224,
                                                                          1.0),
                                                                  fontFamily:
                                                                      'Wellfleet',
                                                                  fontSize:
                                                                      14.0,
                                                                ),
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            const Text(
                                                              'Bus Stop',
                                                              style: TextStyle(
                                                                fontSize: 16.0,
                                                                fontFamily:
                                                                    'Wellfleet',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            Text(
                                                              busStopName,
                                                              style: const TextStyle(
                                                                  fontSize:
                                                                      15.0,
                                                                  fontFamily:
                                                                      'Wellfleet'),
                                                            ),
                                                          ],
                                                        ),
                                                         Column(
                                                          children: [
                                                            const Text(
                                                              'Delivery Time',
                                                              style: TextStyle(
                                                                fontSize: 16.0,
                                                                fontFamily:
                                                                    'Wellfleet',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            Text(
                                                              arrivalTime,
                                                              // ( t.toDate().hour).toString(),
                                                              // currentTime.difference(busTime).abs().inDays.toString(),
                                                              style: const TextStyle(
                                                                fontSize: 15.0,
                                                                fontFamily: 'Wellfleet',
                                                              ),),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          width: 110,
                                                          child: ElevatedButton(
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                30),
                                                                        side:
                                                                            BorderSide(
                                                                          color: Colors
                                                                              .blue
                                                                              .shade900,
                                                                        )),
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
                                                              ),
                                                              onPressed: () {
                                                                showDialog(
                                                                  context: context,
                                                                  builder: (BuildContext context) {
                                                                    return AlertDialog(
                                                                      backgroundColor: Colors.white,
                                                                      title: const Center(
                                                                        child: Text('End The Route',
                                                                          style: TextStyle(
                                                                              fontFamily: 'Wellfleet'
                                                                          ),),
                                                                      ),
                                                                      content: const Text('\tAre you sure you want to finish the route?',
                                                                        style: TextStyle(
                                                                            fontFamily: 'Wellfleet'
                                                                        ),),
                                                                      actions: <Widget>[
                                                                        Row(
                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                          children: [
                                                                            TextButton(
                                                                              style: ButtonStyle(
                                                                                backgroundColor: WidgetStatePropertyAll(Colors.blue.shade900),
                                                                              ),
                                                                              child: const Text('No', style: TextStyle(
                                                                                fontFamily: 'Wellfleet',
                                                                                color: Colors.white,
                                                                              ),
                                                                              ),
                                                                              onPressed: () {
                                                                                Navigator.of(context).pop();
                                                                              },
                                                                            ),
                                                                            TextButton(
                                                                              style: ButtonStyle(
                                                                                backgroundColor: WidgetStatePropertyAll(Colors.blue.shade900),
                                                                              ),
                                                                              child: const Text('Yes',
                                                                                style: TextStyle(
                                                                                  fontFamily: 'Wellfleet',
                                                                                  color: Colors.white,
                                                                                ),),
                                                                              onPressed: () {
                                                                                enableUserLocation();
                                                                                _currentTime =  DateFormat.jm().format(currentTime).toString();
                                                                                arrivalTime = 'No Buses At this Time';
                                                                                busStopName = "No Bus Available";
                                                                                polylineCoordinates.clear();
                                                                                times.clear();
                                                                                setState(() {
                                                                                  index =0;
                                                                                });
                                                                                Navigator.of(context).pop();
                                                                              },
                                                                            ),
                                                                          ],
                                                                        ),

                                                                      ],
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                              child: const Text(
                                                                'Finish',
                                                                style:
                                                                    TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          0,
                                                                          169,
                                                                          224,
                                                                          1.0),
                                                                  fontFamily:
                                                                      'Wellfleet',
                                                                  fontSize:
                                                                      14.0,
                                                                ),
                                                              )),
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
                                                    color: Colors.black
                                                        .withOpacity(0.3),
                                                  ),
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(70),
                                                color: Colors.white,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  data['busNumber'] ?? 'none',
                                                  style: const TextStyle(
                                                      fontSize: 40.0,
                                                      fontFamily: 'Wellfleet'),
                                                ),
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
                            return Padding(
                              padding: const EdgeInsets.all(40.0),
                              child: Center(
                                child: SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 4.0,
                                    color: Colors.blue[900],
                                  ),
                                ),
                              ),
                            );
                          }
                          return Padding(
                            padding: const EdgeInsets.all(40.0),
                            child: Center(
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: CircularProgressIndicator(
                                  strokeWidth: 4.0,
                                  color: Colors.blue[900],
                                ),
                              ),
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
