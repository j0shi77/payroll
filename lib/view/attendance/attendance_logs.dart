import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payroll_app/models/AttendanceList.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

import 'package:intl/intl.dart';

import '../../services/attendance_service.dart';
import 'attendance_detail.dart';

class AttendanceLogsPage extends StatefulWidget {
  const AttendanceLogsPage({Key? key}) : super(key: key);

  @override
  State<AttendanceLogsPage> createState() => _AttendanceListLogsPageState();
}

class _AttendanceListLogsPageState extends State<AttendanceLogsPage> {

  DateTime? month;
  final AttendanceService attendanceService = AttendanceService();
  late List<Data> list = [];
  bool isLoading = false;

  monthPicker() async {

    final selected = await showMonthPicker(
      context: context,
      initialDate: month ?? DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2100),
      locale: const Locale('id', 'ID'),
    );

    setState(() {
      month = selected;

      getAttendanceHistoryByMonth();
    });

  }

  getAttendanceHistoryByMonth() async {
    String monthTmp = DateFormat("yyyy-MM").format(month ?? DateTime.now());
    AttendanceList resp = await attendanceService.fetchAttendanceHistoryByMonth(monthTmp);

    setState(() {
      isLoading = false;
    });

    if(resp.status == 200){
      setState(() {
        list = resp.data!;
      });
    }else{
      showSnackbar(resp.message!);
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

    setState(() {
      isLoading = true;
    });
    getAttendanceHistoryByMonth();
  }

  @override
  Widget build(BuildContext context) {
    var tag = Localizations.maybeLocaleOf(context)?.toLanguageTag();

    return Scaffold(
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
        title: const Text("Log Absensi"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: monthPicker,
                    child: Card(
                      elevation: 0,
                      margin: EdgeInsets.zero,
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        tileColor: const Color.fromARGB(255, 229, 229, 229),
                        title: Text(DateFormat('MMM y ', tag).format(month ?? DateTime.now())),
                        leading: const FaIcon(FontAwesomeIcons.solidCalendar),
                        trailing: const FaIcon(FontAwesomeIcons.caretDown),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if(list.isEmpty && !isLoading) const Text("No data available"),
            if(isLoading) const LinearProgressIndicator(),
            Theme(
                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                child:
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: list.length,
                        itemBuilder:(context, index){
                          return ExpansionTile(
                              iconColor: Colors.black,
                              collapsedIconColor: Colors.black,
                              childrenPadding: EdgeInsets.zero,
                              tilePadding: EdgeInsets.zero,
                              title: Container(
                                decoration: const BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Color(0XFFECECEC), width: 1))),
                                child: ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(list[index].clockIn ?? '', style: const TextStyle(color: Colors.black),),
                                        Container(
                                          constraints: const BoxConstraints(
                                            minWidth: 80, //minimum height
                                          ),
                                          child: Text(list[index].clockOut ?? '', style: const TextStyle(color: Colors.black), textAlign: TextAlign.end,),
                                        )
                                      ],),
                                    leading: Text(
                                      DateFormat('d MMMM','id').format(DateFormat("yyyy-MM-dd", "id").parse(list[index].date??'')),
                                      style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black),)
                                ),
                              ),
                            children:
                            (list[index].detail ?? []).map((item){
                              return InkWell(
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        AttendanceDetail(
                                            item
                                        )),
                                  );
                                },
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(item.attendanceType == 'clock in'?(item.clockIn??''):(item.clockOut??'')),
                                      Container(
                                        constraints: const BoxConstraints(
                                          minWidth: 80, //minimum height
                                        ),
                                        child: Text(
                                            item.attendanceType ?? '',
                                            style: TextStyle(
                                                color: item.attendanceType == 'clock in'? const Color.fromARGB(255, 255, 199, 0) : const Color.fromARGB(255, 255, 37, 37) ),
                                            textAlign : TextAlign.end),
                                      ),
                                      const SizedBox(width: 15),
                                      const Icon(Icons.chevron_right_outlined, color: Colors.black,)
                                    ],
                                  ),
                                ),
                              );
                            }).toList()
                            ,
                          );
                        },
                  )
                )
            )
          ],
        ),
      ),
    );
  }
}
