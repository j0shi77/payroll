import 'package:flutter/material.dart';
import 'package:payroll_app/models/OvertimeDetail.dart';
import 'package:payroll_app/models/UniversalResponse.dart';
import 'package:payroll_app/services/overtime_service.dart';
import 'package:payroll_app/widget/button_custom.dart';
import 'package:intl/intl.dart';
import 'package:payroll_app/widget/date-picker.dart';

import '../../services/secure_storage.dart';

class OvertimeDetailPage extends StatefulWidget {
  const OvertimeDetailPage({Key? key}) : super(key: key);

  @override
  State<OvertimeDetailPage> createState() => _OvertimeDetailPageState();
}

class _OvertimeDetailPageState extends State<OvertimeDetailPage> {

  DateTime? month;
  bool isLoading = false, isLoadingCancelRequest = false;
  final overtimeService = OvertimeService();
  String fullName = '';
  String jobPosition = '';
  final secureStorage = SecureStorage();
  late OvertimeDetail overtimeDetail = OvertimeDetail();
  late num overtimeIdTmp;


  Future showDatetimePicker() {
    return showDialog<Widget>(
        context: context,
        builder: (BuildContext context) {
          return const CustomDatePicker();
        });
  }

  getDetail(num overtimeId) async {
    OvertimeDetail response =  await overtimeService.fetchOvertimeDetail(overtimeId);
    if(response.status == 200){
      setState(() {
        isLoading = false;
        overtimeDetail = response;
      });
    }else{
      setState(() {
        isLoading = false;
      });

      showSnackBar(response.message ?? 'Unknown response');
    }
  }

  cancelRequest(num overtimeId) async {
    UniversalResponse response = await overtimeService.fetchCancelRequest(overtimeId);
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

    var overtimeBeforeTmp = DateTime.parse('1999-01-01 ${overtimeDetail.data?.overtimeBefore ?? '00:00'}:00');
    var breakBeforeTmp = DateTime.parse('1999-01-01 ${overtimeDetail.data?.breakBefore ?? '00:00'}:00');
    var overtimeAfterTmp = DateTime.parse('1999-01-01 ${overtimeDetail.data?.overtimeAfter ?? '00:00'}:00');
    var breakAfterTmp = DateTime.parse('1999-01-01 ${overtimeDetail.data?.breakAfter ?? '00:00'}:00');

    try{
      DateTime.parse('1999-01-01 ${overtimeDetail.data?.overtimeBefore ?? '00:00'}:00');
    }catch(e){
      print("ERRORR "+e.toString());
    }

    var overtimeBefore = '${overtimeBeforeTmp.hour!} Hour ${overtimeBeforeTmp.minute} Minute';
    var breakBefore = '${breakBeforeTmp.hour!} Hour ${breakBeforeTmp.minute} Minute';

    var overtimeAfter = '${overtimeAfterTmp.hour!} Hour ${overtimeAfterTmp.minute} Minute';
    var breakAfter = '${breakAfterTmp.hour!} Hour ${breakAfterTmp.minute} Minute';


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
        title: const Text("Overtime Detail"),
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
                    Text("Requested At"),
                    const SizedBox(height: 8,),
                    Text(DateFormat('dd MMM y').format(DateTime.parse(overtimeDetail.data?.date ?? '0000-00-00')), style: TextStyle(fontWeight: FontWeight.bold),)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Jadwal"),
                    const SizedBox(height: 8,),
                    Text('${overtimeDetail.data?.shiftName} ${overtimeDetail.data?.scheduleIn} - ${overtimeDetail.data?.scheduleOut}', style: TextStyle(fontWeight: FontWeight.bold),)
                  ],
                ),
                Card(
                  margin: EdgeInsets.zero,
                  color: overtimeDetail.data?.status == 'REQUEST'?
                  const Color.fromARGB(255, 245, 241, 241) : (overtimeDetail.data?.status  == 'PENDING'?
                  const Color.fromARGB(255, 255, 249, 228) : overtimeDetail.data?.status  == 'APPROVED'?
                  const Color.fromARGB(255, 237, 255, 251) : overtimeDetail.data?.status  == 'REJECTED'?
                  const Color.fromARGB(255, 255, 237, 237) :
                  const Color.fromARGB(255, 224, 227, 255)),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Text(overtimeDetail.data?.status ?? '', style: TextStyle(fontSize: 12, color: overtimeDetail.data?.status  == 'REQUEST'?
                    const Color.fromARGB(255, 162, 166, 166) : (overtimeDetail.data?.status == 'PENDING'?
                    const Color.fromARGB(255, 255, 199, 0) : overtimeDetail.data?.status == 'APPROVED'?
                    const Color.fromARGB(255, 0, 198, 150) : overtimeDetail.data?.status == 'REJECTED'?
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
                            children: const [
                              Text("Overtime Date"),
                              SizedBox(height: 8,),
                              Text("Compensation Type"),
                              SizedBox(height: 8,),
                              Text("Before Shift", style:  TextStyle(fontWeight: FontWeight.bold),),
                              SizedBox(height: 8,),
                              Text("Request Duration"),
                              SizedBox(height: 8,),
                              Text("Break Duration"),
                              SizedBox(height: 8,),
                              Text("Before Shift", style:  TextStyle(fontWeight: FontWeight.bold),),
                              SizedBox(height: 8,),
                              Text("Request Duration"),
                              SizedBox(height: 8,),
                              Text("Break Duration"),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16,),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(DateFormat('dd MMM y').format(DateTime.parse(overtimeDetail.data?.dateRequest ?? '0000-00-00')), style: const TextStyle(fontWeight: FontWeight.bold),),
                              const SizedBox(height: 8,),
                              Text(overtimeDetail.data?.compensationType?.replaceAll("_", " ") ?? '', style: const TextStyle(fontWeight: FontWeight.bold),),
                              const SizedBox(height: 8,),
                              const Text(""),
                              const SizedBox(height: 8,),
                              Text(overtimeBefore, style: const TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 8,),
                              Text(breakBefore, style: const TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 8,),
                              const Text(""),
                              const SizedBox(height: 8,),
                              Text(overtimeAfter, style: const TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 8,),
                              Text(breakAfter, style: const TextStyle(fontWeight: FontWeight.bold)),
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
                if(overtimeDetail.data?.status == 'APPROVED')(
                    Text(DateFormat('dd MMM y').format(DateTime.parse(overtimeDetail.data?.approvedAt ?? '0000-00-00')), style: const TextStyle(fontWeight: FontWeight.bold),)
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
                children: (overtimeDetail.data?.logsStatus ?? []).map((e) {
                  var index = overtimeDetail.data?.logsStatus?.indexOf(e);

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
                              if((index!+1) != overtimeDetail.data?.logsStatus?.length)(
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
            if(overtimeDetail.data?.status == 'REQUEST')(
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: CButton(title: "Cancel Request",
                    loading: isLoadingCancelRequest,
                    enable: !isLoadingCancelRequest,
                    backgroundColor: const Color.fromARGB(255, 229, 234, 240),
                    textColor : const Color.fromARGB(255, 80, 80, 80),
                    onPressed: (){
                      cancelRequest(overtimeDetail.data?.id ?? 0);
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
