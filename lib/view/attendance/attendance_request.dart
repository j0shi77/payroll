import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payroll_app/models/UniversalResponse.dart';
import 'package:payroll_app/services/attendance_service.dart';
import 'package:payroll_app/widget/button_custom.dart';
import 'package:payroll_app/widget/form_custom.dart';
import 'package:payroll_app/widget/date-picker.dart';
import 'package:intl/intl.dart';

class AttendanceRequest extends StatefulWidget {
  const AttendanceRequest({Key? key}) : super(key: key);

  @override
  State<AttendanceRequest> createState() => _AttendanceRequestState();
}

class _AttendanceRequestState extends State<AttendanceRequest> {

  AttendanceService attendanceService = AttendanceService();
  final editDate = TextEditingController();
  final editClockIn = TextEditingController();
  final editClockOut = TextEditingController();
  final editNote = TextEditingController();
  String date = '', shiftName = '', scheduleIn = '', scheduleOut = '';

  bool isLoading = false,
      checkedClockOut = false,
      checkedClockIn = false,
      enableBtnRequest = false;

  Future showDatetimePicker() {
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

  request() async {

    setState(() {
      isLoading = true;
    });

    UniversalResponse response = await attendanceService.fetchAttendanceRequest(date, editClockIn.text, editClockOut.text, editNote.text);

    setState(() {
      isLoading = false;
    });

    if(response.status == 200){
      showSnackBar(response.message!);
      //clear
      date = '';
      editNote.clear();
      editClockOut.clear();
      editClockIn.clear();
      checkedClockOut = false;
      checkedClockIn = false;
    }else{
      showSnackBar(response.message!);
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
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          iconSize: 32,
          onPressed: () {
             Navigator.pop(context);
          },
          icon: const Icon(Icons.chevron_left_outlined),
        ),
        title: const Text("Ajukan Absensi"),
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
              children: [
                Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
                child: FormIconCustom(
                  label: "Kapan",
                  icon: Icons.calendar_month,
                  controller: editDate,
                  onTap: showDatetimePicker,
                  readOnly: true,),
                ),
                if(shiftName != '')(
                  Column(
                    children: [
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(left: 57),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:  [
                                const Text("SHIFT", style: TextStyle(fontWeight: FontWeight.bold),),
                                const SizedBox(height: 8,),
                                Text(shiftName)
                              ],
                            ),
                            const SizedBox(width: 16,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("SCHEDULE IN", style: TextStyle(fontWeight: FontWeight.bold),),
                                const SizedBox(height: 8,),
                                Text(scheduleIn)
                              ],
                            ),
                            const SizedBox(width: 16,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("SCHEDULE OUT", style: TextStyle(fontWeight: FontWeight.bold),),
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
                Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CheckboxCustom(
                    title: "Clock In",
                    controller: editClockIn,
                    onChangeSelected: (bool? value) async {

                      if(!value!){
                        editClockIn.text='';
                        setState(() {
                          checkedClockIn = false;
                        });
                        return;
                      }

                      TimeOfDay? time = await getTime(context: context, title: 'Clock In');
                      setState(() {
                        if(time?.hour.toString() == null){
                          editClockIn.text='';
                          checkedClockIn = false;
                        }else{
                          editClockIn.text='${time?.hour.toString().padLeft(2, '0')}:${time?.minute.toString().padLeft(2, '0')}';
                          checkedClockIn = true;
                        }
                      });

                    },
                    checked: checkedClockIn,
                  ),
                ),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CheckboxCustom(
                    title: "Clock Out",
                    controller: editClockOut,
                    onChangeSelected: (bool? value) async {

                      if(!value!){
                        editClockOut.text='';
                        setState(() {
                          checkedClockOut = false;
                        });
                        return;
                      }

                      TimeOfDay? time = await getTime(context: context, title: 'Clock Out');
                      setState(() {
                        if(time?.hour.toString() == null){
                          editClockOut.text = '';
                          checkedClockOut = false;
                        }else{
                          editClockOut.text = '${time?.hour.toString().padLeft(2, '0')}:${time?.minute.toString().padLeft(2, '0')}';
                          checkedClockOut = true;
                        }
                      });

                    },
                    checked: checkedClockOut,
                  ),
                ),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: FormIconCustom(
                    label: "Keterangan",
                    icon: Icons.notes_rounded,
                    controller: editNote,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CButton(
                      title: "Ajukan",
                      enable: enableBtnRequest,
                      loading: isLoading,
                      onPressed: (){
                        request();
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