
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:payroll_app/helpers/Constant.dart';
import 'package:payroll_app/services/attendance_service.dart';
import 'package:payroll_app/widget/button_custom.dart';
import 'package:payroll_app/widget/form_custom.dart';
import 'package:payroll_app/widget/date-picker.dart';
import 'package:intl/intl.dart';

import '../../models/UniversalResponse.dart';
import '../../services/overtime_service.dart';
import '../../services/secure_storage.dart';

class OvertimeRequest extends StatefulWidget {
  const OvertimeRequest({Key? key}) : super(key: key);

  @override
  State<OvertimeRequest> createState() => _OvertimeRequestState();
}

class _OvertimeRequestState extends State<OvertimeRequest> {

  final editDate = TextEditingController();
  final editOvertimeBefore = TextEditingController();
  final editBreakBefore = TextEditingController();
  final editOvertimeAfter = TextEditingController();
  final editBreakAfter = TextEditingController();
  final editNotes = TextEditingController();
  final overtimeService = OvertimeService();
  final attendanceService = AttendanceService();
  String date = '', shiftName = '', scheduleIn = '', scheduleOut = '';
  bool enableBtnRequest = false, isLoading = false;

  final int maxFiles = 4;
  late List<String> imagesForReq = [];
  late List<String> images = [""];
  final SecureStorage secureStorage = SecureStorage();

  Future showDatePicker() {
    return showDialog<Widget>(
        context: context,
        builder: (BuildContext context) {
          return CustomDatePicker(
            onSubmit: (val) async {
              setState(() {
                date = val.toString().substring(0,10);
              });

              editDate.text = DateFormat("dd MMMM yyyy", "id_ID").format(DateTime.parse(date));
              Navigator.pop(context);

              await getScheduleByDate();
            },
            initialSelectedDate: date.isEmpty?DateTime.now():DateTime.parse(date),
          );
        });
  }

  Future<TimeOfDay?> timePicker({
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

  getScheduleByDate() async {
    var response = await attendanceService.fetchGetScheduleByDate(date);
    if(response.status == 200){
      setState(() {
        if(response.data != null){
          if(response.data?.showInRequest == 1){
            shiftName = response.data!.shiftName!;
            scheduleIn = response.data!.workingHourStart!;
            scheduleOut = response.data!.workingHourEnd!;
          }
          enableBtnRequest = true;
        }else{
          enableBtnRequest = false;
          showSnackBar(response!.message!);
        }
      });
    }else{
      showSnackBar('get schedule by date has been failed, ${response!.message!}');
    }
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
        .child("paid_leave/${DateFormat('yyyyMMdd').format(DateTime.parse(date))}_ID${userId}_$i.jpg")
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

            String hour = '', minute = '';
            String overtimeBefore = '';
            if(editOvertimeBefore.text != ''){
              hour = editOvertimeBefore.text.replaceAll(" jam ", ":").replaceAll(" menit", "").split(':')[0].padLeft(2,'0');
              minute = editOvertimeBefore.text.replaceAll(" jam ", ":").replaceAll(" menit", "").split(':')[1].padLeft(2,'0');
              overtimeBefore = '$hour:$minute';
            }

            hour = '';
            minute = '';
            String breakBefore = '';
            if(editBreakBefore.text != ''){
              hour = editBreakBefore.text.replaceAll(" jam ", ":").replaceAll(" menit", "").split(':')[0].padLeft(2,'0');
              minute = editBreakBefore.text.replaceAll(" jam ", ":").replaceAll(" menit", "").split(':')[1].padLeft(2,'0');
              breakBefore = '$hour:$minute';
            }

            hour = '';
            minute = '';
            String overtimeAfter = '';
            if(editOvertimeAfter.text != ''){
              hour = editOvertimeAfter.text.replaceAll(" jam ", ":").replaceAll(" menit", "").split(':')[0].padLeft(2,'0');
              minute = editOvertimeAfter.text.replaceAll(" jam ", ":").replaceAll(" menit", "").split(':')[1].padLeft(2,'0');
              overtimeAfter = '$hour:$minute';
            }

            hour = '';
            minute = '';
            String breakAfter = '';
            if(editBreakAfter.text != ''){
              hour = editBreakAfter.text.replaceAll(" jam ", ":").replaceAll(" menit", "").split(':')[0].padLeft(2,'0');
              minute = editBreakAfter.text.replaceAll(" jam ", ":").replaceAll(" menit", "").split(':')[1].padLeft(2,'0');
              breakAfter = '$hour:$minute';
            }

            if(i == images.length - 2){
              UniversalResponse response = await overtimeService.fetchRequest(
                  DateFormat('yyyy-MM-dd').format(DateTime.parse(date)),
                  'paid_overtime',
                  overtimeBefore,
                  breakBefore,
                  overtimeAfter,
                  breakAfter,
                  editNotes.text,
                  images
              );

              if(response.status == 200){
                editOvertimeBefore.text = "";
                editBreakBefore.text = "";
                editOvertimeAfter.text = "";
                editBreakAfter.text = "";
                editNotes.text = "";
                editDate.text = "";
                setState(() {
                  //clear
                  date = '';
                  images = [''];
                  shiftName = '';
                });

                showSnackBar(response.message ?? 'Response unknown');

                setState(() {
                  isLoading = false;
                  enableBtnRequest = false;
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
      images[index] = pickedImage!.path;

      if(action == 'ADD' && images.length < maxFiles){
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

      images[index] = pickedImage!.path;

      if(action == 'ADD' && images.length < maxFiles){
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

  requestOvertime() async {

    //dismiss keyboard
    FocusManager.instance.primaryFocus?.unfocus();

    //validation
    if(date == null){
      showSnackBar("Gagal, Silakan isi tanggal");
      return;
    }

    if(editOvertimeBefore.text == '' && editOvertimeAfter.text == ''){
      showSnackBar("Gagal, Silakan isi salah satu durasi overtime (sebelum atau sesudah)");
      return;
    }

    if(editNotes.text == ''){
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

    for (int i=0;i<imgFiles.length;i++) {

      if(imgFiles[i].path != ''){
        await uploadToFirebase(imgFiles[i], i);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          iconSize: 32,
          onPressed: () {
             Navigator.pop(context);
          },
          icon: const Icon(Icons.chevron_left_outlined),
        ),
        title: const Text("Request Overtime"),
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
            // height: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: FormIconCustom(
                      label: "Select Date",
                      icon: Icons.calendar_month,
                      controller: editDate,
                      readOnly: true,
                      onTap: showDatePicker,
                    ),
                ),
                if(shiftName != '')(
                    Column(
                      children: [
                        const SizedBox(height: 0),
                        Padding(
                          padding: const EdgeInsets.only(left: 57),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:  [
                                  const Text("Shift", style: TextStyle(color: Color.fromARGB(
                                      255, 162, 166, 166)),),
                                  const SizedBox(height: 8,),
                                  Text(shiftName)
                                ],
                              ),
                              const SizedBox(width: 16,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Schedule In", style: TextStyle(color: Color.fromARGB(
                                      255, 162, 166, 166)),),
                                  const SizedBox(height: 8,),
                                  Text(scheduleIn)
                                ],
                              ),
                              const SizedBox(width: 16,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Schedule Out", style: TextStyle(color: Color.fromARGB(
                                      255, 162, 166, 166)),),
                                  const SizedBox(height: 8,),
                                  Text(scheduleOut)
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    )

                ),

                const Padding(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: FormIconCustom(
                    label: "Compensation",
                    icon: Icons.dashboard,
                    readOnly: true,
                    initialValue: "Paid Compensation",
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text("Sebelum Shift", style: TextStyle(fontWeight: FontWeight.bold),)
                ),
                Row(
                  children: [
                    Expanded(
                      child:
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: FormIconCustom(label: "Durasi Overtime", readOnly: true, onTap: () async {
                          String hour = '', minute = '';
                          if(editOvertimeBefore.text != ''){
                            hour = editBreakBefore.text.replaceAll(" jam ", ":").replaceAll(" menit", "").split(':')[0].padLeft(2,'0');
                            minute = editBreakBefore.text.replaceAll(" jam ", ":").replaceAll(" menit", "").split(':')[1].padLeft(2,'0');
                          }

                          TimeOfDay? time = await timePicker(
                              context: context,
                              title: 'Durasi Overtime (Sebelum Shift)',
                              initialTime: editOvertimeBefore.text == '' ? const TimeOfDay(hour: 00, minute: 00) : TimeOfDay(hour: int.parse(hour), minute: int.parse(minute))
                          );
                          setState(() {
                            if(time?.hour.toString() == null){
                              editOvertimeBefore.text = '';
                            }else{
                              editOvertimeBefore.text = '${time?.hour} jam ${time?.minute} menit';
                            }
                          });

                        }, icon: FontAwesomeIcons.clock, controller: editOvertimeBefore),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: FormIconCustom(label: "Durasi Istirahat", readOnly: true, onTap: () async {
                          String hour = '', minute = '';
                          if(editBreakBefore.text != ''){
                            hour = editBreakBefore.text.replaceAll(" jam ", ":").replaceAll(" menit", "").split(':')[0].padLeft(2,'0');
                            minute = editBreakBefore.text.replaceAll(" jam ", ":").replaceAll(" menit", "").split(':')[1].padLeft(2,'0');
                          }
                          TimeOfDay? time = await timePicker(
                              context: context,
                              title: 'Durasi Istirahat (Sebelum Shift)',
                              initialTime: editBreakBefore.text == '' ? const TimeOfDay(hour: 00, minute: 00) : TimeOfDay(hour: int.parse(hour), minute: int.parse(minute))
                          );

                          setState(() {
                            if(time?.hour.toString() == null){
                              editBreakBefore.text = '';
                            }else{
                              editBreakBefore.text = '${time?.hour} jam ${time?.minute} menit';
                            }
                          });

                        }, icon: FontAwesomeIcons.clock, controller: editBreakBefore,),
                      ),
                    ),
                  ],
                ),
                const Padding(
                    padding: EdgeInsets.only(left: 16, top: 16),
                    child: Text("Setelah Shift", style: TextStyle(fontWeight: FontWeight.bold),)
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: FormIconCustom(label: "Durasi Overtime", readOnly: true, onTap: () async {

                          String hour = '', minute = '';
                          if(editOvertimeAfter.text != ''){
                            hour = editOvertimeAfter.text.replaceAll(" jam ", ":").replaceAll(" menit", "").split(':')[0].padLeft(2,'0');
                            minute = editOvertimeAfter.text.replaceAll(" jam ", ":").replaceAll(" menit", "").split(':')[1].padLeft(2,'0');
                          }

                          TimeOfDay? time = await timePicker(
                              context: context,
                              title: 'Durasi Overtime (Setelah Shift)',
                              initialTime: editOvertimeAfter.text == '' ? const TimeOfDay(hour: 00, minute: 00) : TimeOfDay(hour: int.parse(hour), minute: int.parse(minute))
                          );

                          setState(() {
                            if(time?.hour.toString() == null){
                              editOvertimeAfter.text = '';
                            }else{
                              editOvertimeAfter.text = '${time?.hour} jam ${time?.minute} menit';
                            }
                          });

                        }, icon: FontAwesomeIcons.clock, controller: editOvertimeAfter,),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: FormIconCustom(label: "Durasi Istirahat", readOnly: true, onTap: () async {

                          String hour = '', minute = '';
                          if(editBreakAfter.text != ''){
                            hour = editBreakAfter.text.replaceAll(" jam ", ":").replaceAll(" menit", "").split(':')[0].padLeft(2,'0');
                            minute = editBreakAfter.text.replaceAll(" jam ", ":").replaceAll(" menit", "").split(':')[1].padLeft(2,'0');
                          }

                          TimeOfDay? time = await timePicker(
                              context: context,
                              title: 'Durasi Istirahat (Setelah Shift)',
                              initialTime: editBreakAfter.text == '' ? const TimeOfDay(hour: 00, minute: 00) : TimeOfDay(hour: int.parse(hour), minute: int.parse(minute))
                          );

                          setState(() {
                            if(time?.hour.toString() == null){
                              editBreakAfter.text = '';
                            }else{
                              editBreakAfter.text = '${time?.hour} jam ${time?.minute} menit';
                            }
                          });

                        }, icon: FontAwesomeIcons.clock, controller: editBreakAfter),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child:FormIconCustom(
                    label: "Keterangan",
                    icon: Icons.notes_rounded,
                    controller: editNotes,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 28,),
                    const Icon(Icons.file_upload_outlined, color: Color.fromARGB(255, 137, 137, 137),),
                    const SizedBox(width: 12,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        const Text("Upload File",style: TextStyle(color: clLabel, fontSize: 16)
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
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Divider(height: 1, color: clLabel,),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    children: [
                      CButton(title: "Ajukan Lembur", loading: isLoading, enable: !isLoading && enableBtnRequest, onPressed: (){
                        if(!isLoading){
                          requestOvertime();
                        }
                      }),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
