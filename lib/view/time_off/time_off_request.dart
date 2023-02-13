import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:payroll_app/models/TimeOffEmployeeList.dart' hide Data;
import 'package:payroll_app/models/TimeOffTypeList.dart';
import 'package:payroll_app/models/UniversalResponse.dart';
import 'package:payroll_app/services/time_off_service.dart';
import 'package:payroll_app/widget/button_custom.dart';
import 'package:payroll_app/widget/form_custom.dart';
import 'package:intl/intl.dart';

import '../../services/secure_storage.dart';

class TimeOffRequest extends StatefulWidget {
  const TimeOffRequest({Key? key}) : super(key: key);

  @override
  State<TimeOffRequest> createState() => _TimeOffRequestState();
}

class _TimeOffRequestState extends State<TimeOffRequest> {

  DateTime? startDate, endDate;
  late List<String> timeOffTypeListStr = [];
  late List<String> requestTypes = ['Full Day','Half Day - Before Break','Half Day - After Break'];
  late List<String> requestTypesOrigin = ['FULL_DAY','HALF_DAY_BEFORE_BREAK','HALF_DAY_AFTER_BREAK'];
  String requestType = '', requestTypeOrigin = '';
  late List<Data> timeOffTypeListOri;
  late List<String> images = [""];
  late List<String> employeeList = [];
  late List<String> imagesForReq = [];
  final SecureStorage secureStorage = SecureStorage();

  final TimeOffService announcementService = TimeOffService();

  final delegate = TextEditingController();
  final selectDate = TextEditingController();
  bool isLoadEmployeeList = false;

  late int timeOffId;
  String timeOffName = '';
  late String employeeId = '';
  final description = TextEditingController();

  final int maxFiles = 4;

  bool isLoading = false;
  final scheduleInController = TextEditingController();
  final scheduleOutController = TextEditingController();

  getTimeOffTypeList() async {
    TimeOffTypeList response = await announcementService.fetchTimeOffList();

    if(response.status == 200){
      setState(() {
        response.data?.forEach((element) {
          timeOffTypeListStr.add(element.name ?? '');
        });

        timeOffTypeListOri = response.data!;

        if(timeOffTypeListOri.isNotEmpty){
          timeOffId = timeOffTypeListOri[0].id!;
        }
      });
    }else {

    }
  }

  requestTimeOff() async {

    //dismiss keyboard
    FocusManager.instance.primaryFocus?.unfocus();

    //validation
    if(startDate == null || endDate == null){
      showSnackBar("Gagal, Silakan isi tanggal awal dan tanggal akhir");
      return;
    }

    if(description.text == ''){
      showSnackBar("Gagal, Silakan isi keterangan");
      return;
    }

    if(description.text == ''){
      showSnackBar("Gagal, Silakan isi keterangan");
      return;
    }

    if(images.length == 1){
      showSnackBar("Gagal, Silakan upload file pendukung");
      return;
    }

    setState(() {
      isLoading = true;
    });

    //reinit images
    imagesForReq = [];

    print('imgFiles.length ${imgFiles.length}');

    for (int i=0;i<imgFiles.length;i++) {

      print('e.value.path ${imgFiles[i].path}');

      if(imgFiles[i].path != ''){
        await uploadToFirebase(imgFiles[i], i);
      }
    }
  }

  getEmployeeList() async {
    TimeOffEmployeeList response = await announcementService.fetchEmployeeList(delegate.text);

    if(response.status == 200){

      setState(() {

        //clear
        employeeList = [];

        //add
        response.data?.forEach((element) {
          employeeList.add('${element.id}~~${element.fullName}~~${element.jobPositionName}');
        });

      });
    }else {

    }

    setState(() {
      isLoadEmployeeList = false;
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

  showDate() async {

    var result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2022, 1, 1), // the earliest allowable
      lastDate: DateTime(2050, 1, 1), // the latest allowable
      currentDate: DateTime.now(),
      saveText: 'Simpan',
      fieldStartHintText: 'Start Date',
      initialDateRange: DateTimeRange(start: startDate ?? DateTime.now(), end: endDate ?? DateTime.now()),
      fieldEndHintText: 'End Date',
      builder: ( context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            brightness: Brightness.light,
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
              onPrimary: Colors.white,
              surface: Theme.of(context).primaryColor,
              onSurface: Colors.black, //month color,
            ),
          ),
          child: child!,
        );
      } ,
    );

    setState(() {
      startDate = result?.start;
      endDate = result?.end;

      selectDate.text = (startDate != null && endDate != null)?
      '${DateFormat("d MMMM yyyy", "id_ID").format(startDate!)} - ${DateFormat("d MMMM yyyy", "id_ID").format(endDate!)}'
          : '';
    });

  }

  uploadToFirebase(File imgFile, int i) async {

    if(imgFile == null){
      showSnackBar("Please take file first"); return;
    }

    // Create the file metadata
    final metadata = SettableMetadata(contentType: "image/jpeg");

    // Create a reference to the Firebase Storage bucket
    final storageRef = FirebaseStorage.instance.ref();

    var fileName = imgFile.path.split("/")[imgFile.path.split("/").length-1];
    print('file name $fileName');
    // Upload file and metadata to the path 'images/mountains.jpg'

    String userId = await secureStorage.readSecureData(key: 'id');
    final uploadTask = storageRef
        .child("time_off/TO_MOBILE_${DateFormat('yyyyMMdd').format(startDate!)}_${DateFormat('yyyyMMdd').format(endDate!)}_ID${userId}_$i.jpg")
        .putFile(imgFile, metadata);

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
          await taskSnapshot.ref.getDownloadURL().then((downloadURL) async {
            imagesForReq.add(downloadURL);
            
            if(i == images.length - 2){
              UniversalResponse response = await announcementService.fetchRequest(
                timeOffId.toString(),
                DateFormat('yyyy-MM-dd').format(startDate!),
                DateFormat('yyyy-MM-dd').format(endDate!),
                imagesForReq,
                employeeId,
                requestTypeOrigin,
                scheduleInController.text,
                scheduleOutController.text
              );

              if(response.status == 200){
                setState(() {
                  //clear
                  employeeList = [];
                  delegate.text = '';
                  description.text = '';
                  images = [''];

                  startDate = null;
                  endDate = null;
                });

                showSnackBar(response.message ?? 'Response unknown');

                setState(() {
                  isLoading = false;
                });
              }else {
                showSnackBar(response.message ?? 'Response unknown');

                setState(() {
                  isLoading = false;
                });
              }
            }
          });
          
          break;
      }
    });
  }

  List<File> imgFiles = [File("")];
  String imgPath = '';
  bool isActionChange = false;

  Future takeCamera(int index, String action)  async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera, maxWidth: 200, maxHeight: 200);

    //dismiss keyboard
    FocusManager.instance.primaryFocus?.unfocus();

    if(imgFiles.isEmpty){
      imgFiles.add(File(""));
    }

    setState(() {
      //set val bby index
      imgFiles[index] = File(pickedImage!.path);
      images[index] = pickedImage.path;

      if(action == 'ADD' && images.length <= maxFiles){
        imgFiles.add(File(""));
        images.add("");
      }
    });
  }

  Future takeGallery(int index, String action)  async {

    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery, maxWidth: 200, maxHeight: 200);

    //dismiss keyboard
    FocusManager.instance.primaryFocus?.unfocus();

    if(imgFiles.isEmpty){
      imgFiles.add(File(""));
    }

    setState(() {
      imgFiles[index] = File(pickedImage!.path);

      images[index] = pickedImage.path;

      if(action == 'ADD' && images.length <= maxFiles){
        imgFiles.add(File(""));
        images.add("");
      }
    });
  }

  removeFile(int index){

    //dismiss keyboard
    FocusManager.instance.primaryFocus?.unfocus();

    setState(() {
      imgFiles.removeAt(index);
      images.removeAt(index);
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getTimeOffTypeList();
  }

  showDialogUpload(int index, String action){

    //show list dialog
    Widget optionFour = SimpleDialogOption(
      child: const ListTile(
        title: Text("Galeri"),
      ),
      onPressed: () {
        Navigator.pop(context);
        takeGallery(index, action);
      },
    );

    Widget optionFive = SimpleDialogOption(
      child: const ListTile(
        title: Text("Kamera"),
      ),
      onPressed: () {
        Navigator.pop(context);
        takeCamera(index, action);
      },
    );

    // set up the SimpleDialog
    SimpleDialog dialog = SimpleDialog(
      title: const Text('Pilih dari:'),
      children: <Widget>[
        optionFour,
        optionFive,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );

  }

  Future<TimeOfDay?> getTime({
    required BuildContext context,
    String? title,
    TimeOfDay? initialTime,
    String? cancelText,
    String? confirmText,
  }) async {

    TimeOfDay? time = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,

      initialTime: initialTime ?? TimeOfDay.now(),
      cancelText: cancelText ?? "Batal",
      confirmText: confirmText ?? "Simpan",
      helpText: title ?? "Pilih Waktu",
      builder: (context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              // change the border color
              primary: Theme.of(context).primaryColor,
              // change the text color
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    return time;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          iconSize: 32,
          onPressed: () {
             Navigator.pop(context);
          },
          icon: const Icon(Icons.chevron_left_outlined),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Request Time Off"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 150,
          ),
          child: SizedBox(
            // height: 600,
            child: Column(
              children: [
                const SizedBox(height: 16,),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: OptionCustom(
                      textHint: "Jenis Cuti",
                      icon: Icons.next_week,
                      items: timeOffTypeListStr,
                      onChanged: (data){
                        setState(() {
                          timeOffId   = timeOffTypeListOri[data!].id!;
                          timeOffName = timeOffTypeListOri[data].name!;
                          requestTypeOrigin = '';
                        });
                      }
                  ),
                ),
                if(timeOffName.toLowerCase() == 'izin')(
                  Column(
                    children: [
                      Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: OptionCustom(
                            textHint: "Request Type",
                            icon: FontAwesomeIcons.clock,
                            items: requestTypes,
                            onChanged: (i){
                              setState(() {
                                requestType = requestTypes[i!];
                                requestTypeOrigin = requestTypesOrigin[i];
                              });
                            }
                        ),
                      ),
                      if(requestTypeOrigin == 'HALF_DAY_BEFORE_BREAK' || requestTypeOrigin == 'HALF_DAY_AFTER_BREAK')(
                          Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: FormIconCustom(
                                      label: 'Schedule In',
                                      icon: FontAwesomeIcons.clock,
                                      controller: scheduleInController,
                                      readOnly: true,
                                      onTap: () async {
                                        if(scheduleInController.text != ''){
                                          scheduleInController.text = '';
                                        }else{
                                          TimeOfDay? time = await getTime(context: context, title: "Schedule In");
                                          if(time?.hour != null)
                                            scheduleInController.text = '${time?.hour.toString().padLeft(2, '0')}:${time?.minute.toString().padLeft(2, '0')}';
                                        }
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 16,),
                                  Expanded(
                                    child: FormIconCustom(
                                      label: 'Schedule Out',
                                      icon: FontAwesomeIcons.clock,
                                      controller: scheduleOutController,
                                      readOnly: true,
                                      onTap: () async {
                                        if(scheduleOutController.text != ''){
                                          scheduleOutController.text = '';
                                        }else{
                                          TimeOfDay? time = await getTime(context: context, title: "Schedule In");
                                          if(time?.hour != null)
                                            scheduleOutController.text = '${time?.hour.toString().padLeft(2, '0')}:${time?.minute.toString().padLeft(2, '0')}';
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              )
                          )
                      )
                    ],
                  )
                ),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: FormIconCustom(
                    label: "Select Date",
                    icon: Icons.calendar_month,
                    controller: selectDate,
                    readOnly: true,
                    onTap: showDate,
                    suffixIcon: const Icon(Icons.keyboard_arrow_down_outlined),
                  ),
                ),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
                 child: FormIconCustom(
                   label: "Keterangan",
                   icon: Icons.notes_rounded,
                   controller: description,
                 ),
                ),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: AutoCompleteCustom(
                    hint: "Cari berdasarkan nama...",
                    label: "Delegasikan Personal (opsional)",
                    icon: Icons.person,
                    controller: delegate,
                    suggestions: employeeList,
                    onChanged: (String val) {

                      if(isLoadEmployeeList){
                        return;
                      }

                      setState(() {
                        isLoadEmployeeList = true;
                      });

                      getEmployeeList();
                    },
                    onItemSelected: (String val){
                      setState(() {
                        employeeId = val.split('~~')[0];
                      });
                    },
                    onRemoved: (){
                      setState(() {
                        employeeId = '';
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 28,),
                    const Icon(Icons.file_upload_outlined, color: Color.fromARGB(255, 137, 137, 137),),
                    const SizedBox(width: 12,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        const Text("Upload File",style: TextStyle(color: Color.fromARGB(
                            255, 93, 93, 93), fontSize: 16)
                        ),
                        const SizedBox(height: 16,),
                        Row(
                          children: images.asMap().entries.map((url){
                            int index = url.key;

                            if(url.value == ''){
                              return Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: InkWell(
                                  onTap: (){
                                    showDialogUpload(index, 'ADD');
                                  },
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  child: Container(
                                      decoration:  BoxDecoration(
                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                          border: Border.all(
                                            color: const Color.fromARGB(255, 93, 93, 93),
                                            style: BorderStyle.solid,
                                            width: 1.0,
                                          )
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Icon(Icons.add, color: Color.fromARGB(
                                            255, 93, 93, 93),),
                                      )
                                  ),
                                ),
                              );
                            }else{
                              return Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: InkWell(
                                  onTap: (){

                                    //show list dialog
                                    Widget optionFour = SimpleDialogOption(
                                      child: const ListTile(
                                        title: Text("Ganti"),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        showDialogUpload(index, 'CHANGE');
                                      },
                                    );
                                    Widget optionFive = SimpleDialogOption(
                                      child: const ListTile(
                                        title: Text("Hapus"),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        removeFile(index);
                                      },
                                    );

                                    // set up the SimpleDialog
                                    SimpleDialog dialog = SimpleDialog(
                                      title: const Text('Pilih'),
                                      children: <Widget>[
                                        optionFour,
                                        optionFive,
                                      ],
                                    );

                                    // show the dialog
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return dialog;
                                      },
                                    );

                                  },
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10), // Image border
                                    child: Image.file(File(url.value), height: 41, width: 41, fit: BoxFit.cover),
                                  ),
                                ),
                              );
                            }
                          }).toList(),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 16,),
                const Padding(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Divider(height: 1, color: Color.fromARGB(255, 173, 171, 171),),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: CButton(
                    loading: isLoading,
                    title: "Request Time Off",
                    onPressed: (){
                      if(!isLoading){
                        requestTimeOff();
                      }
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
