import 'package:flutter/material.dart';
import 'package:payroll_app/models/UniversalResponse.dart';
import 'package:payroll_app/services/attendance_service.dart';
import 'package:payroll_app/widget/button_custom.dart';
import 'package:intl/intl.dart';
import 'package:payroll_app/widget/date-picker.dart';

import '../../models/AttendanceRequestDetail.dart';
import '../../services/secure_storage.dart';

class AttendanceRequestDetailPage extends StatefulWidget {
  const AttendanceRequestDetailPage({Key? key}) : super(key: key);

  @override
  State<AttendanceRequestDetailPage> createState() => _AttendanceRequestDetailPageState();
}

class _AttendanceRequestDetailPageState extends State<AttendanceRequestDetailPage> {

  DateTime? month;
  bool isLoading = false, isLoadingCancelRequest = false;
  final attendanceService = AttendanceService();
  String fullName = '';
  String jobPosition = '';
  final secureStorage = SecureStorage();
  late AttendanceRequestDetail detail = AttendanceRequestDetail();
  late num overtimeIdTmp;


  Future showDatetimePicker() {
    return showDialog<Widget>(
        context: context,
        builder: (BuildContext context) {
          return const CustomDatePicker();
        });
  }

  getDetail(num reqId) async {
    AttendanceRequestDetail response =  await attendanceService.fetchAttendanceRequestDetail(reqId);
    if(response.status == 200){
      setState(() {
        isLoading = false;
        detail = response;
      });
    }else{
      setState(() {
        isLoading = false;
      });

      showSnackBar(response.message ?? 'Unknown response');
    }
  }

  cancelRequest(num reqId) async {

    //show dialog
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed:  () {Navigator.of(context).pop();},
    );
    Widget continueButton = TextButton(
      child: const Text("Continue"),
      onPressed:  () async {
        //dismiss
        Navigator.of(context).pop();

        UniversalResponse response = await attendanceService.fetchCancelRequest(reqId);
        if(response.status == 200){
          setState(() {
            isLoadingCancelRequest = false;
          });
        }else{
          setState(() {
            isLoadingCancelRequest = false;
          });
        }

        showSnackBar(response.message ?? 'Unknown response');

        //refresh data
        getDetail(overtimeIdTmp);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Confirmation"),
      content: const Text("Select continue to cancel the request"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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

    setState(() {
      isLoading = true;
    });

    Future.delayed(Duration.zero, () {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, num?>;
      final id = args["id"];
      overtimeIdTmp = id!;

      print(id);

      getDetail(id!);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          iconSize: 32,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.chevron_left_outlined),
        ),
        title: const Text("Attendance Detail"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          children: [
            if(isLoading) const LinearProgressIndicator(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Requested At"),
                    const SizedBox(height: 8,),
                    Text(DateFormat('dd MMM y').format(DateTime.parse(detail.data?.date ?? '0000-00-00')), style: const TextStyle(fontWeight: FontWeight.bold),)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Jadwal"),
                    const SizedBox(height: 8,),
                    Text('${detail.data?.shiftName} ${detail.data?.scheduleIn} - ${detail.data?.scheduleOut}', style: const TextStyle(fontWeight: FontWeight.bold),)
                  ],
                ),
                Card(
                  margin: EdgeInsets.zero,
                  color: detail.data?.status == 'REQUEST'?
                  const Color.fromARGB(255, 245, 241, 241) : (detail.data?.status  == 'PENDING'?
                  const Color.fromARGB(255, 255, 249, 228) : detail.data?.status  == 'APPROVED'?
                  const Color.fromARGB(255, 237, 255, 251) : detail.data?.status  == 'REJECTED'?
                  const Color.fromARGB(255, 255, 237, 237) :
                  const Color.fromARGB(255, 224, 227, 255) ),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Text(detail.data?.status ?? '', style: TextStyle(fontSize: 12, color: detail.data?.status  == 'REQUEST'?
                    const Color.fromARGB(255, 162, 166, 166) : (detail.data?.status == 'PENDING'?
                    const Color.fromARGB(255, 255, 199, 0) : detail.data?.status == 'APPROVED'?
                    const Color.fromARGB(255, 0, 198, 150) : detail.data?.status == 'REJECTED'?
                    const Color.fromARGB(255, 255, 37, 37) :
                    const Color.fromARGB(255, 0, 5, 51))) ),
                  ),
                ),

              ],
            ),
            const SizedBox(height: 16,),
            Card(
              elevation: 0,
              margin: EdgeInsets.zero,
              color: const Color.fromARGB(255, 249, 249, 249),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text("Request Detail", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                  ),
                  const Divider(height: 1,),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          flex:0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Tanggal Absensi"),
                              const SizedBox(height: 8,),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 8),
                                child: Text("Clock In"),
                              ),
                              if(detail.data?.clockIn != '') const Padding(
                                padding: EdgeInsets.only(bottom: 8),
                                child: Text("Clock out"),
                              ),
                              if(detail.data?.clockOut != '') const Padding(
                                padding: EdgeInsets.only(bottom: 8),
                                child: Text("Deskripsi"),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(width: 16,),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(DateFormat('dd MMM y').format(DateTime.parse(detail.data?.date ?? '0000-00-00')), style: const TextStyle(fontWeight: FontWeight.bold),),
                              const SizedBox(height: 8,),
                              if(detail.data?.clockIn != '') Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(detail.data?.clockIn ?? '', style: const TextStyle(fontWeight: FontWeight.bold),),
                              ),
                              if(detail.data?.clockOut != '') Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(detail.data?.clockOut ?? '', style: const TextStyle(fontWeight: FontWeight.bold),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(detail.data?.note ?? '', style: const TextStyle(fontWeight: FontWeight.bold),),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ),
                ]
              )
            ),
            const SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Tanggal Persetujuan"),
                if(detail.data?.status == 'APPROVED')(
                    Text(DateFormat('dd MMM y').format(DateTime.parse(detail.data?.approvedAt ?? '0000-00-00')), style: const TextStyle(fontWeight: FontWeight.bold),)
                )else(
                    const Text("-", style: TextStyle(fontWeight: FontWeight.bold),)
                )
              ],
            ),
            const SizedBox(height: 16,),
            const Divider(height: 1,),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8),
                children: (detail.data?.logsStatus ?? []).map((e) {
                  var index = detail.data?.logsStatus?.indexOf(e);

                  return
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        left: 0,
                        top: 4,
                        child: SizedBox(
                          child: Column(
                            children: [
                              Icon(Icons.circle, size: 9, color: e?.status  == 'REQUEST'?
                              const Color.fromARGB(255, 162, 166, 166) : (e?.status == 'PENDING'?
                              const Color.fromARGB(255, 255, 199, 0) : e?.status == 'APPROVED'?
                              const Color.fromARGB(255, 0, 198, 150) : e?.status == 'REJECTED'?
                              const Color.fromARGB(255, 255, 37, 37) :
                              const Color.fromARGB(255, 0, 5, 51))),
                              if((index!+1) != detail.data?.logsStatus?.length)(
                                  Container(
                                    margin: const EdgeInsets.only(left:4, right: 4),
                                    color:const Color.fromARGB(255, 162, 166, 166),
                                    width: 1,
                                    height: 50,
                                  )
                              )
                              ,
                            ],
                          ),
                        )
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(e?.status ?? '', style: TextStyle(color: e?.status  == 'REQUEST'?
                                const Color.fromARGB(255, 162, 166, 166) : (e?.status == 'PENDING'?
                                const Color.fromARGB(255, 255, 199, 0) : e?.status == 'APPROVED'?
                                const Color.fromARGB(255, 0, 198, 150) : e?.status == 'REJECTED'?
                                const Color.fromARGB(255, 255, 37, 37) :
                                const Color.fromARGB(255, 0, 5, 51)), fontWeight: FontWeight.bold),),
                                const SizedBox(width: 5,),
                                Text(e?.description ?? '')
                              ],
                            ),
                            const SizedBox(height: 8,),
                            Text(DateFormat('dd MMM y').format(DateTime.parse(e?.createdAt ?? '0000-00-00 00:00:00')), style: const TextStyle(color: Color.fromARGB(
                                255, 170, 169, 169)),),
                            const SizedBox(
                              height: 16,
                            )
                          ],
                        ),
                      )
                    ],
                  );}
                ).toList(),
              ),
            ),
            if(detail.data?.status == 'REQUEST')(
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: CButton(title: "Cancel Request",
                    loading: isLoadingCancelRequest,
                    enable: !isLoadingCancelRequest,
                    backgroundColor: const Color.fromARGB(255, 229, 234, 240),
                    textColor : const Color.fromARGB(255, 80, 80, 80),
                    onPressed: (){
                      cancelRequest(detail.data?.id ?? 0);
                    }),
              )
            )
          ],
        ),
      )
    );
  }
}


class OvertimeDetailArguments {
  final num? id;

  OvertimeDetailArguments(this.id);
}
