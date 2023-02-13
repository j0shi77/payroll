import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class GoogleMapsDemo extends StatefulWidget {
  const GoogleMapsDemo({Key? key}) : super(key: key);

  @override
  State<GoogleMapsDemo> createState() => _GoogleMapsDemoState();
}

class _GoogleMapsDemoState extends State<GoogleMapsDemo> {
  late GoogleMapController mapController;
  final Completer<GoogleMapController> _mapController = Completer();
  static Position? _position;
  static double? distanceInMeters;

  // Maps
  Set<Circle> _circles = HashSet<Circle>();
  late double radius = 20;

  // ids
  int _circleIdCounter = 1;

  // markers
  static final Marker _kOfficeMarker = Marker(
      markerId: MarkerId('_kOffice'),
      infoWindow: InfoWindow(title: 'Office Marker'),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(_position!.latitude, _position!.longitude));

  void _onMapCreated(GoogleMapController controller) {
    _mapController.complete(controller);
  }

  void _getCurrentPosition() async {
    Position position = await _determinePosition();
    setState(() {
      _position = position;
    });

    distanceInMeters = Geolocator.distanceBetween(-6.123815774844222,
        106.72943583984733, -6.123834803853831, 106.72901160947063);
    debugPrint('jarak ${distanceInMeters}');
  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location Permissions are denied");
      }
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
  }

  void _setCircles(LatLng point) {
    final String circleIdVal = 'circle_id_$_circleIdCounter';
    _circleIdCounter++;
    print(
        'Circle | Latitude: ${point.latitude}  Longitude: ${point.longitude}  Radius: $radius');
    _circles.add(Circle(
        circleId: CircleId(circleIdVal),
        center: point,
        radius: radius,
        fillColor: Colors.redAccent.withOpacity(0.5),
        strokeWidth: 3,
        strokeColor: Colors.redAccent));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps Demo'),
      ),
      body: Column(
        children: [
          _position != null
              ? Center(
                  child: SizedBox(
                    height: 400,
                    child: GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target:
                            LatLng(_position!.latitude, _position!.longitude),
                        zoom: 19.0,
                      ),
                      markers: {_kOfficeMarker},
                    ),
                  ),
                )
              : const Text("Loading"),
          Center(
              child: Column(
            children: [
              _position != null
                  ? Text("current Location: " + _position.toString())
                  : Text("No Location Data"),
              Text('jarak: ${distanceInMeters.toString()}')
            ],
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getCurrentPosition,
        tooltip: 'get current',
        child: const Icon(Icons.location_city),
      ),
    );
  }
}
