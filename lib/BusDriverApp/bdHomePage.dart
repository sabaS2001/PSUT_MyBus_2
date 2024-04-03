import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'locationServices.dart' ;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';


class BDHomePage extends StatefulWidget {
  const BDHomePage({super.key});

  @override
  State<BDHomePage> createState() => _BDHomePageState();
}

class _BDHomePageState extends State<BDHomePage> {
  final Completer<GoogleMapController> _controller = Completer();
  final TextEditingController _origin = TextEditingController();
  final TextEditingController _destination = TextEditingController();

  final Set<Marker> _markers = <Marker>{};
  final Set<Polygon> _polygons = <Polygon>{};
  final Set<Polyline> _polylines = <Polyline>{};
  List<LatLng> polygonLatLngs = <LatLng>[];

  late  int _polygonIdCounter = 1;
  late int _polylineIdCounter = 1;

  @override
  void initState() {
    super.initState();
    _setMarker(const LatLng(31.89946887031427, 35.83674782804591));
  }

  void _setMarker(LatLng point) {
    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId('marker'),
          position: point,
        ),
      );
    });
  }

  void _setPolygon() {
    final String polygonIdVal = 'polygon_$_polygonIdCounter';
    _polygonIdCounter++;

    _polygons.add(
      Polygon(
        polygonId: PolygonId(polygonIdVal),
        points: polygonLatLngs,
        strokeWidth: 2,
        fillColor: Colors.transparent,
      ),
    );
  }

  void _setPolyline(List<PointLatLng> points) {
    final String polylineIdVal = 'polyline_$_polylineIdCounter';
    _polylineIdCounter++;

    _polylines.add(
      Polyline(
        polylineId: PolylineId(polylineIdVal),
        width: 2,
        color: Colors.blue,
        points: points
            .map(
              (point) => LatLng(point.latitude, point.longitude),
        )
            .toList(),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    TextFormField(
                      textCapitalization: TextCapitalization.words ,
                      controller: _origin,
                      decoration: const InputDecoration(
                        hintText: 'Current Location',
                      ),
                      onChanged: (value){
                        print(value);
                      },
                    ),
                    TextFormField(
                      textCapitalization: TextCapitalization.words ,
                      controller: _destination,
                      decoration: const InputDecoration(
                        hintText: 'Destination',
                      ),
                      onChanged: (value){
                        print(value);
                      },
                    ),
                  ],
                ),
              ),
              IconButton(onPressed: () async {
                var directions = await LocationService().getDirections(
                  _origin.text,
                  _destination.text,
                );
                goToPlace(
                  directions['start_location']['lat'],
                  directions['start_location']['lng'],
                  directions['bounds_ne'],
                  directions['bounds_sw'],
                );

                _setPolyline(directions['polyline_decoded']);
              },
                  icon: const Icon(Icons.search,
                    color: Colors.black,)),
            ],
          ),
        ),
        body: GoogleMap(
          polygons: _polygons,
          polylines: _polylines,
          markers: _markers,
          onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
          },
          mapType: MapType.terrain,
          initialCameraPosition: const CameraPosition(
            target: LatLng(37.42796133580664, -122.085749655962),
            zoom: 14.4746,
          ),
        ),

      ),
    );
  }

  Future<void> goToPlace( double lat, double lng, Map<String, dynamic> boundsNe, Map<String, dynamic> boundsSw,) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 12),
      ),
    );
    controller.animateCamera(
      CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: LatLng(boundsSw['lat'], boundsSw['lng']),
            northeast: LatLng(boundsNe['lat'], boundsNe['lng']),
          ),
          25),
    );
    _setMarker(LatLng(lat, lng));
  }
}

//Getting the current bus driver's location
Future <Position> getCurrentLocation() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if(!serviceEnabled){
    return Future.error('Location Servies Disabled');
  }

  LocationPermission permission = await Geolocator.checkPermission();
  if(permission == LocationPermission.denied){
    permission = await Geolocator.requestPermission();
    if(permission == LocationPermission.denied){
      Future.error("Permission is denied");
    }
  }
  return await Geolocator.getCurrentPosition();
}
