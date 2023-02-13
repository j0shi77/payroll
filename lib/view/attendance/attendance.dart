import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:payroll_app/models/Attendance.dart';
import 'package:payroll_app/models/AttendanceHistory.dart';
import 'package:payroll_app/models/AttendanceHistoryResponse.dart';
import 'package:payroll_app/models/AttendanceList.dart';
import 'package:payroll_app/models/AttendanceResponse.dart';
import 'package:payroll_app/services/attendance_service.dart';
import 'package:payroll_app/view/attendance/in_out_attendance.dart';
import 'package:payroll_app/widget/button_custom.dart';

import 'attendance_detail.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({Key? key}) : super(key: key);
  static String pathName = '/attendance/list';

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {

  final AttendanceService attendanceService = AttendanceService();
  Attendance ?attendance;
  List<AttendanceHistory> attendanceHistory = [];
  bool allowBtnClockIn = true;
  bool allowBtnClockOut = true;

  String timeString = '';

  getScheduleToday() async {

    //get today date
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);

    AttendanceResponse response = await attendanceService.fetchGetScheduleByDate(formattedDate);

    if(response.status == 200){
      setState(() {
        attendance = response.data;
      });
    }else {
      //error
    }

  }

  getAttendanceHistory() async {

    //get today date
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String date = formatter.format(now);

    AttendanceHistoryResponse response = await attendanceService.fetchGetAttendanceHistory(date, date);

    if(response.status == 200){
      setState(() {
        attendanceHistory = response.data ?? [];
      });

      for (var element in attendanceHistory) {
        if(element.attendanceType == 'clock in'){
          allowBtnClockIn = false;
        }

        if(element.attendanceType == 'clock out'){
          allowBtnClockOut = false;
        }
      }
    }else {
      //error
    }
  }

  onPressedClockInOut(String type) async {

    if(attendance?.shiftName != null && attendance?.shiftName != 'dayoff'){

      if(type == 'IN' && !allowBtnClockIn){
        showSnackbar("You have been clock in");
        return;
      }

      if(type == 'OUT' && !allowBtnClockOut){
        showSnackbar("You have been clock out");
        return;
      }

      if(type == 'OUT' && allowBtnClockIn && allowBtnClockOut){
        showSnackbar("Please clock in first");
        return;
      }

      var result = await Navigator.push(
        context,
        MaterialPageRoute(
            settings: RouteSettings(arguments: {
              'type' : type
            }),
            builder: (context) =>
            const InOutAttendance()),
      );

      //get result success
      if(result == true){
        //if success refresh attendance history
        getAttendanceHistory();
      }
    }else{
      var snackMessage = '';
      if(attendance?.shiftName == 'dayoff'){
        snackMessage = "Day off";
      }else{
        snackMessage = "Not available schedule in today";
      }

      showSnackbar(snackMessage);

    }
  }

  showSnackbar(String message){
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

    getScheduleToday();

    getAttendanceHistory();

    Timer.periodic(const Duration(seconds: 1), (Timer t) {
      getTime();
    });

  }

  void getTime() {
    final String formattedTime = DateFormat('hh:mm').format(DateTime.now());
    setState(() {
      timeString = formattedTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: size.height * 0.5,
              color: const Color(0XFFFFFFFF),
              child: Stack(
                children: [
                  Positioned.fill(
                    bottom: 40,
                    child: SizedBox(
                      width: 42.0,
                      height: 42.0,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Material(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(56),
                      child: InkWell(
                        onTap: (){Navigator.pop(context);},
                        borderRadius: BorderRadius.circular(56),
                        child: Container(
                          alignment: Alignment.center,
                          width: 56,
                          height: 56,
                          child: const FaIcon(
                            FontAwesomeIcons.angleLeft,
                            color: Color(0XFFFFFFFF),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Text(
                          "Live Absen",
                          style: TextStyle(
                              color: Color(0XFFFFFFFF),
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          timeString,
                          style: const TextStyle(
                              color: Color(0XFFFFFFFF),
                              fontWeight: FontWeight.w700,
                              fontSize: 28),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          DateFormat("EEEE, d MMMM yyyy", "id_ID")
                              .format(DateTime.now()),
                          style: const TextStyle(
                              color: Color(0XFFFFFFFF),
                              fontWeight: FontWeight.w400,
                              fontSize: 16),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Card(
                          margin: EdgeInsets.zero,
                          color: const Color(0XFF4684EB),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Wrap(
                              spacing: 8,
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: const [
                                FaIcon(
                                  FontAwesomeIcons.circleExclamation,
                                  size: 14,
                                  color: Color(0XFFFFFFFF),
                                ),
                                Text(
                                  "Selfie untuk melakukan absen",
                                  style: TextStyle(
                                      fontSize: 12, color: Color(0XFFFFFFFF)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          attendance?.shiftName ?? '',
                          style: const TextStyle(
                              fontSize: 20,
                              color: Color(0XFFFFFFFF),
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 8,
                          crossAxisAlignment:
                          WrapCrossAlignment.center,
                          children: [
                            Text(
                              attendance?.workingHourStart ?? '',
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Color(0XFFFFFFFF),
                                  fontWeight: FontWeight.bold),
                            ),
                            const FaIcon(
                              FontAwesomeIcons.minus,
                              color: Colors.white,
                              size: 14,
                            ),
                            Text(
                              attendance?.workingHourEnd ?? '',
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Color(0XFFFFFFFF),
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: (size.height * 0.5) * 0.82,
                    bottom: 0,
                    left: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: const Color(0XFFFFFFFF),
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 0.5,
                              blurRadius: 15,
                              offset: const Offset(
                                0.0, // Move to right 10  horizontally
                                15.0, // Move to bottom 10 Vertically
                              ),
                            )
                          ]),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 4),
                              child: CButton(
                                title: 'Clock In',
                                onPressed: () {
                                  onPressedClockInOut('IN');
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 4),
                                child: CButton(
                                  title: 'Clock Out',
                                  onPressed: () {
                                    onPressedClockInOut('OUT');
                                  },
                                ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                // color: const Color(0XFFE5E5E5),
                width: double.infinity,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 30),
                    child: Wrap(
                      direction: Axis.horizontal,
                      runSpacing: 20,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Riwayat Absen",
                              style: TextStyle(
                                  color: Color(0XFF4684EB),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed('/attendance/logs');
                              },
                              child: Text(
                                'Lihat Log',
                                style: TextStyle(color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ],
                        ),
                        if(attendanceHistory.isEmpty) const Text("No data.", style: TextStyle(color: Colors.black54),),
                        Column(
                          children: attendanceHistory.map((item) =>
                              InkWell(
                                  onTap: (){

                                    Detail data = Detail(
                                      clockIn: item.clockIn,
                                      clockOut: item.clockOut,
                                      attendanceCode: item.attendanceCode,
                                      createdAt: item.createdAt,
                                      image: item.image,
                                      note: item.note,
                                      latitude: item.latitude,
                                      longitude: item.longitude,
                                      attendanceType: item.attendanceType
                                    );

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AttendanceDetail(
                                                  data
                                              )),
                                    );

                                  },
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric( vertical: 8),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(flex:1, child: Text(
                                            item.attendanceType == 'clock out'?(item.clockOut ?? ''):(item.clockIn ?? ''),
                                            style: const TextStyle(
                                                color: Color(0XFF3C3C3C),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          )),
                                          Card(
                                            elevation: 0,
                                            color: item.attendanceType == 'clock in' ? const Color.fromARGB(
                                                255, 237, 255, 251) : const Color.fromARGB(
                                                255, 255, 237, 237),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                                              child: Text(
                                                item.attendanceType ?? '',
                                                style: TextStyle(fontSize: 18, color: (item.attendanceType == 'clock in')?
                                                const Color.fromARGB(255, 0, 198, 150): const Color.fromARGB(255, 255, 37, 37) ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 29,),
                                          const FaIcon(
                                            FontAwesomeIcons.angleRight,
                                            color: Color(0XFF717171),
                                          )
                                        ],
                                      )
                                  )
                              ),
                          ).toList(),
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
