import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:payroll_app/helpers/Helper.dart';
import 'package:payroll_app/models/UniversalResponse.dart';
import 'package:payroll_app/widget/button_custom.dart';
import 'package:payroll_app/widget/form_custom.dart';

import '../../services/attendance_service.dart';

class InOutAttendance extends StatefulWidget {
  const InOutAttendance({Key? key}) : super(key: key);

  @override
  State<InOutAttendance> createState() => _InOutAttendanceState();
}

class _InOutAttendanceState extends State<InOutAttendance> {

  File ?imgFile;
  String imgPath = '';
  final editNote = TextEditingController();
  bool isLoading = false;
  String title = '';
  bool enableBtnSend = true;

  GoogleMapController? _controller;
  Location currentLocation = Location();
  final Set<Marker> _markers={};

  double? lat, long;

  final AttendanceService attendanceService = AttendanceService();
  late StreamSubscription<LocationData> locationSubscription;

  uploadToFirebase() async {
    
    if(imgFile == null){
      showSnackBar("Please take picture first"); return;
    }

    setState(() {
      isLoading = true;
    });

    // Create the file metadata
    final metadata = SettableMetadata(contentType: "image/jpeg");

    // Create a reference to the Firebase Storage bucket
    final storageRef = FirebaseStorage.instance.ref();

    var fileName = imgPath.split("/")[imgPath.split("/").length-1];
    print('file name $fileName');
    // Upload file and metadata to the path 'images/mountains.jpg'
    final uploadTask = storageRef
          .child("attendanceImages/$fileName")
          .putFile(imgFile!, metadata);

    // Listen for state changes, errors, and completion of the upload.
    uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) async {
      switch (taskSnapshot.state) {
        case TaskState.running:
          final progress =
              100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
          print("Upload is $progress% complete.");
          break;
        case TaskState.paused:
          print("Upload is paused.");
          setState(() {
            isLoading = false;
          });
          break;
        case TaskState.canceled:
          print("Upload was canceled");
          setState(() {
            isLoading = false;
          });
          break;
        case TaskState.error:
          // Handle unsuccessful uploads
          break;
        case TaskState.success:
          // Handle successful uploads on complete
          // ...

          UniversalResponse resp;
          String timeNow = DateFormat.Hm().format(DateTime.now());

          if(title == 'Clock In'){
            await taskSnapshot.ref.getDownloadURL().then((downloadURL) async {

              resp = await attendanceService.fetchClockIn(
                  getTodayDate(),
                  timeNow,
                  lat.toString(),
                  long.toString(),
                  editNote.text,
                  downloadURL
              );

              showSnackBar(resp.message ?? 'Unknown response');

              if(resp.status == 200){
                editNote.text = '';
                imgFile = null;

                back();
              }

              setState(() {
                isLoading = false;
              });
            });

          }else if(title == 'Clock Out'){
            await taskSnapshot.ref.getDownloadURL().then((downloadURL) async {
              resp = await attendanceService.fetchClockOut(
                  getTodayDate(),
                  timeNow,
                  lat.toString(),
                  long.toString(),
                  editNote.text,
                  downloadURL
              );

              showSnackBar(resp.message ?? 'Unknown response');

              if(resp.status == 200){
                editNote.text = '';
                imgFile = null;

                back();
              }

              setState(() {
                isLoading = false;
              });

            });
          }

          break;
      }
    });
  }

  back(){
    Navigator.pop(context,true);
  }

  void getLocation() async{

    var location = await currentLocation.getLocation();

    locationSubscription = currentLocation.onLocationChanged.listen((LocationData loc){

      if(lat == null && long == null){
        _controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(loc.latitude ?? 0.0,loc.longitude?? 0.0),
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
          position: LatLng(location.latitude ?? 0.0, location.longitude ?? 0.0)
      ));

      enableBtnSend = true;
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

  Future takeCamera()  async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera, maxWidth: 200, maxHeight: 200);

    setState(() {
      imgFile = File(pickedImage!.path);

      imgPath = pickedImage!.path;
    });
  }

  removeImage(){
    setState(() {
      imgFile = null;
      imgPath = '';
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      enableBtnSend = false;
    });

    var args;
    Future.delayed(Duration.zero, () {
      setState(() {
        args = ModalRoute.of(context)!.settings.arguments;
        title = args['type'] == 'IN'? 'Clock In':'Clock Out';
      });

      getLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          iconSize: 32,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.chevron_left_outlined),
        ),
        flexibleSpace: Image.asset(
          'assets/images/bg_header_login.png',
          fit: BoxFit.cover,
        ),
        title: Text(
          title,
          style: const TextStyle(
              color: Color(0XFFFFFFFF),
              fontWeight: FontWeight.w400,
              fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child:  GoogleMap(
                zoomControlsEnabled: false,
                initialCameraPosition:const CameraPosition(
                target: LatLng(-6.1375686,106.8124393),
                zoom: 15.0,
              ),
              onMapCreated: (GoogleMapController controller){
                _controller = controller;
              },
              markers: _markers,
            ),
          ),
          FormIconCustom(
            label: "Catatan",
            icon: Icons.notes_rounded,
            controller : editNote,
          ),
          Row(
            children: [
              const SizedBox(width: 16,),
              const Icon(Icons.camera_alt, color: Color.fromARGB(255, 177, 177, 177)),
              const SizedBox(width: 22,),
              InkWell(
                onTap: (){ takeCamera(); },
                child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text("Ambil Gambar", style: TextStyle(color: Color.fromARGB(255, 86, 86, 86))
                  ),
                ),
              )
            ],
          ),
          if(imgFile != null) Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Image.file( imgFile!, width: 100, height: 100, fit: BoxFit.cover),
              Positioned(
                bottom: 0,
                right: -10,
                child: ElevatedButton(
                    onPressed: removeImage,
                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Theme.of(context).primaryColor)),
                    child: const  Padding(
                      padding: EdgeInsets.all(5),
                      child: FaIcon(
                        FontAwesomeIcons.minus,
                        color: Colors.white,
                      ),
                    )
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CButton(
            enable: (enableBtnSend && !isLoading),
              loading: isLoading,
              title: "Kirim",
              onPressed: () {
                uploadToFirebase();
              }),
          )
        ],
      ),
    );
  }
}
