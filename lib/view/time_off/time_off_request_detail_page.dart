import 'package:flutter/material.dart';
import 'package:payroll_app/models/TimeOffRequestDetail.dart';
import 'package:payroll_app/models/UniversalResponse.dart';
import 'package:payroll_app/services/time_off_service.dart';
import 'package:payroll_app/widget/button_custom.dart';
import 'package:intl/intl.dart';
import 'package:payroll_app/widget/date-picker.dart';

import '../../services/secure_storage.dart';

class TimeOffRequestDetailPage extends StatefulWidget {
  const TimeOffRequestDetailPage({Key? key}) : super(key: key);

  @override
  State<TimeOffRequestDetailPage> createState() => _TimeOffRequestDetailPageState();
}

class _TimeOffRequestDetailPageState extends State<TimeOffRequestDetailPage> {

  DateTime? month;
  bool isLoading = false, isLoadingCancelRequest = false;
  final timeOffService = TimeOffService();
  String fullName = '';
  String jobPosition = '';
  final secureStorage = SecureStorage();
  late TimeOffRequestDetail detail = TimeOffRequestDetail();
  late num overtimeIdTmp;


  Future showDatetimePicker() {
    return showDialog<Widget>(
        context: context,
        builder: (BuildContext context) {
          return const CustomDatePicker();
        });
  }

  getDetail(num overtimeId) async {
    TimeOffRequestDetail response =  await timeOffService.fetchRequestDetail(overtimeId);
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

  cancelRequest(num id) async {
    UniversalResponse response = await timeOffService.fetchCancelRequest(id);
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

    //resfresh data
    getDetail(overtimeIdTmp);
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

      getDetail(id);
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
        title: const Text("Time Off Detail"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          children: [
            if(isLoading) const Padding( padding: EdgeInsets.only(bottom: 16), child: LinearProgressIndicator(), ),
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
                  const Color.fromARGB(255, 224, 227, 255)),
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
                  const SizedBox(height: 4,),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Table(
                      columnWidths: const {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(2),
                      },
                      children: [
                        TableRow(children: [
                          const Text("Time Off Date"),
                          Text(DateFormat('dd MMM y').format(DateTime.parse(detail.data?.date ?? '0000-00-00')), style: const TextStyle(fontWeight: FontWeight.bold),)
                        ]),
                        const TableRow(
                            children: [
                              SizedBox(height: 8),//SizeBox Widget
                              SizedBox(height: 8)
                            ]
                        ),
                        TableRow(children: [
                          const Text("Time Off Type"),
                          Text(detail.data?.timeOffDsc ?? '', style: const TextStyle(fontWeight: FontWeight.bold),),
                        ]),
                        const TableRow(
                            children: [
                              SizedBox(height: 8),//SizeBox Widget
                              SizedBox(height: 8)
                            ]
                        ),
                        TableRow(children: [
                          const Text("Request Type"),
                          Text(detail.data?.requestType?.replaceAll("_", " ") ?? '', style: const TextStyle(fontWeight: FontWeight.bold),),
                        ]),
                        const TableRow(
                            children: [
                              SizedBox(height: 8),//SizeBox Widget
                              SizedBox(height: 8)
                            ]
                        ),
                        if((detail.data?.requestType??'').contains("HALF"))(
                        TableRow(children: [
                            const Text("Schedule In"),
                            Text(detail.data?.scheduleInHalfDay ?? '', style: const TextStyle(fontWeight: FontWeight.bold),)
                          ])
                        ),
                        if((detail.data?.requestType??'').contains("HALF"))(
                            const TableRow(
                                children: [
                                  SizedBox(height: 8),//SizeBox Widget
                                  SizedBox(height: 8)
                                ]
                            )
                        ),
                        if((detail.data?.requestType??'').contains("HALF"))(
                            TableRow(children: [
                              const Text("Schedule Out"),
                              Text(detail.data?.scheduleOutHalfDay ?? '', style: const TextStyle(fontWeight: FontWeight.bold),)
                            ])
                        ),
                        if((detail.data?.requestType??'').contains("HALF"))(
                            const TableRow(
                                children: [
                                  SizedBox(height: 8),//SizeBox Widget
                                  SizedBox(height: 8)
                                ]
                            )
                        ),
                        TableRow(
                            children: [
                              const Text("Taken"),
                              Text("${detail.data?.taken.toString() ?? 0} Day${(detail.data?.taken ?? 0)>1?'s':''}", style: const TextStyle(fontWeight: FontWeight.bold),),
                            ]
                        ),
                        const TableRow(
                            children: [
                              SizedBox(height: 8),//SizeBox Widget
                              SizedBox(height: 8)
                            ]
                        ),
                        TableRow(
                            children: [
                              const Text("Notes"),
                              Text(detail.data?.note ?? '', style: const TextStyle(fontWeight: FontWeight.bold),),
                            ]
                        ),
                        const TableRow(
                            children: [
                              SizedBox(height: 8),//SizeBox Widget
                              SizedBox(height: 8)
                            ]
                        ),
                        TableRow(
                            children: [
                              const Text("File"),
                              SizedBox(
                                height: 41,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: (detail.data?.images ?? []).map((imageUrl) => Padding(padding: const EdgeInsets.only(right: 8), child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10), // Image border
                                    child: Image.network(imageUrl, height: 41, width: 41, fit: BoxFit.cover),
                                  )),).toList(),
                                ),
                              )
                            ]
                        )
                      ],
                    ),
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
                              Icon(Icons.circle, size: 9, color: e.status  == 'REQUEST'?
                              const Color.fromARGB(255, 162, 166, 166) : (e.status == 'PENDING'?
                              const Color.fromARGB(255, 255, 199, 0) : e.status == 'APPROVED'?
                              const Color.fromARGB(255, 0, 198, 150) : e.status == 'REJECTED'?
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
                                Text(e.status ?? '', style: TextStyle(color: e.status  == 'REQUEST'?
                                const Color.fromARGB(255, 162, 166, 166) : (e.status == 'PENDING'?
                                const Color.fromARGB(255, 255, 199, 0) : e.status == 'APPROVED'?
                                const Color.fromARGB(255, 0, 198, 150) : e.status == 'REJECTED'?
                                const Color.fromARGB(255, 255, 37, 37) :
                                const Color.fromARGB(255, 0, 5, 51)), fontWeight: FontWeight.bold),),
                                const SizedBox(width: 5,),
                                Text(e.description ?? '')
                              ],
                            ),
                            const SizedBox(height: 8,),
                            Text(DateFormat('dd MMM y').format(DateTime.parse(e.createdAt ?? '0000-00-00 00:00:00')), style: const TextStyle(color: Color.fromARGB(
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
