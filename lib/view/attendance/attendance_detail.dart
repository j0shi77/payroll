import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:payroll_app/models/AttendanceList.dart';
import 'package:geocoding/geocoding.dart' hide Location;

class AttendanceDetail extends StatefulWidget {

  const AttendanceDetail(this.item, {Key? key}) : super(key: key);

  final Detail item;

  @override
  State<AttendanceDetail> createState() => _AttendanceDetailState();
}

class _AttendanceDetailState extends State<AttendanceDetail> {

  GoogleMapController? _controller;
  Location currentLocation = Location();
  final Set<Marker> _markers={};
  late StreamSubscription<LocationData> locationSubscription;

  double? lat, long;
  String address = '';

  void getLocation() async{

    locationSubscription = currentLocation.onLocationChanged.listen((LocationData loc){

      if(lat == null && long == null) {
        _controller?.animateCamera(
            CameraUpdate.newCameraPosition(CameraPosition(
              target: LatLng(double.parse(widget.item.latitude ?? ''),
                  double.parse(widget.item.longitude ?? '')),
              zoom: 15.0,
            )));
      }else{
        locationSubscription.pause();
      }

      lat = loc.latitude;
      long = loc.longitude;
    });
    
    setState(() {

      _markers.add(Marker(markerId: const MarkerId('Home'),
          position: LatLng(double.parse(widget.item.latitude??''), double.parse(widget.item.longitude??''))
      ));

    });
  }

  getAddressByLatLong() async {
    await placemarkFromCoordinates(
        double.parse(widget.item.latitude!), double.parse(widget.item.longitude!))
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];

      setState(() {
        address = '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}, ${place.country}';
      });

      print(address);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  showSnackBar(String message){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {
            // Code to execute.
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getLocation();

    getAddressByLatLong();

    print('widget.item.attendanceType ${widget.item.attendanceType}');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    print("DISPOSE");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          iconSize: 32,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.chevron_left_outlined),
        ),
        title: const Text(
          'Detail Absensi',
          style: TextStyle(
              color: Color(0XFFFFFFFF),
              fontWeight: FontWeight.w400,
              fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: SizedBox(
                  height: 180,
                  // width: MediaQuery.of(context).size.width,
                  child:  GoogleMap(
                    zoomControlsEnabled: false,
                    initialCameraPosition:const CameraPosition(
                      target: LatLng(-6.181084,106.7064775),
                      zoom: 15.0,
                    ),
                    onMapCreated: (GoogleMapController controller){
                      _controller = controller;
                    },
                    markers: _markers,
                  ),
                )
              ),
              Expanded(flex: 1,child: Image.network(widget.item.image!, height: 180, fit: BoxFit.cover,))
            ],
          ),
          const SizedBox(height: 14,),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Waktu", style: TextStyle(color: Color.fromARGB(255, 162, 166, 166)),),
                    const SizedBox(height: 5,),
                    Text(widget.item.attendanceType == 'clock in'? (widget.item.clockIn ?? '') : (widget.item.clockOut ?? '') )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 33),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Type", style: TextStyle(color: Color.fromARGB(255, 162, 166, 166))),
                    const SizedBox(height: 5,),
                    Text(widget.item.attendanceType ?? '' )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 33),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Tanggal", style: TextStyle(color: Color.fromARGB(255, 162, 166, 166))),
                    const SizedBox(height: 5,),
                    Text(DateFormat('d MMMM yyyy', 'id_ID').format(DateTime.parse(widget.item.createdAt ?? '').toLocal()) )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 5,),
          const Padding(
            padding: EdgeInsets.symmetric( horizontal: 12 ),
            child: Divider(indent: 1),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Lokasi", style: TextStyle(color: Color.fromARGB(255, 162, 166, 166)),),
                const SizedBox(height: 5,),
                Text(address)
              ],
            ),
          ),
          const SizedBox(height: 5,),
          const Padding(
            padding: EdgeInsets.symmetric( horizontal: 12 ),
            child: Divider(indent: 1),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Catatan", style: TextStyle(color: Color.fromARGB(255, 162, 166, 166)),),
                const SizedBox(height: 5,),
                Text(widget.item.note??'-')
              ],
            ),
          ),
          const SizedBox(height: 5,),
          const Padding(
            padding: EdgeInsets.symmetric( horizontal: 12 ),
            child: Divider(indent: 1),
          ),
        ],
      ),
    );
  }
}
