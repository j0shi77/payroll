import 'package:flutter/material.dart';
import 'package:payroll_app/models/UniversalResponse.dart';
import 'package:payroll_app/widget/button_custom.dart';
import 'package:intl/intl.dart';
import 'package:payroll_app/widget/date-picker.dart';

import '../../models/ShiftDetail.dart';
import '../../services/secure_storage.dart';
import '../../services/shift_service.dart';

class ShiftDetailPage extends StatefulWidget {
  const ShiftDetailPage({Key? key}) : super(key: key);

  @override
  State<ShiftDetailPage> createState() => _ShiftDetailPageState();
}

class _ShiftDetailPageState extends State<ShiftDetailPage> {

  DateTime? month;
  bool isLoading = false, isLoadingCancelRequest = false;
  final shiftService = ShiftService();
  String fullName = '';
  String jobPosition = '';
  final secureStorage = SecureStorage();
  late ShiftDetail shiftDetail = ShiftDetail();
  late num shiftIdTmp;


  Future showDatetimePicker() {
    return showDialog<Widget>(
        context: context,
        builder: (BuildContext context) {
          return const CustomDatePicker();
        });
  }

  getDetail(num shiftId) async {
    ShiftDetail response =  await shiftService.fetchOvertimeDetail(shiftId);
    if(response.status == 200){
      setState(() {
        isLoading = false;
        shiftDetail = response;
      });
    }else{
      setState(() {
        isLoading = false;
      });

      showSnackBar(response.message ?? 'Unknown response');
    }
  }

  cancelRequest(num shiftId) async {
    UniversalResponse response = await shiftService.fetchCancelRequest(shiftId);
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
    getDetail(shiftIdTmp);
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
      shiftIdTmp = id!;

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
        title: const Text("Shift Detail"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(isLoading) const LinearProgressIndicator(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Requested At"),
                        const SizedBox(height: 8,),
                        Text(DateFormat('dd MMM y').format(DateTime.parse(shiftDetail.data?.date ?? '0000-00-00')), style: const TextStyle(fontWeight: FontWeight.bold),)
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 48),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("From Schedule"),
                          const SizedBox(height: 8,),
                          Text('${shiftDetail.data?.currentShiftName} ${shiftDetail.data?.currentShiftScheduleIn} - ${shiftDetail.data?.currentShiftScheduleOut}', style: const TextStyle(fontWeight: FontWeight.bold),)
                        ],
                      ),
                    )
                  ],
                ),
                Card(
                  margin: EdgeInsets.zero,
                  color: shiftDetail.data?.status == 'REQUEST'?
                  const Color.fromARGB(255, 245, 241, 241) : (shiftDetail.data?.status  == 'PENDING'?
                  const Color.fromARGB(255, 255, 249, 228) : shiftDetail.data?.status  == 'APPROVED'?
                  const Color.fromARGB(255, 237, 255, 251) : shiftDetail.data?.status  == 'REJECTED'?
                  const Color.fromARGB(255, 255, 237, 237) :
                  const Color.fromARGB(255, 224, 227, 255)),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Text(shiftDetail.data?.status ?? '', style: TextStyle(fontSize: 12, color: shiftDetail.data?.status  == 'REQUEST'?
                    const Color.fromARGB(255, 162, 166, 166) : (shiftDetail.data?.status == 'PENDING'?
                    const Color.fromARGB(255, 255, 199, 0) : shiftDetail.data?.status == 'APPROVED'?
                    const Color.fromARGB(255, 0, 198, 150) : shiftDetail.data?.status == 'REJECTED'?
                    const Color.fromARGB(255, 255, 37, 37) :
                    const Color.fromARGB(255, 0, 5, 51))) ),
                  ),
                ),

              ],
            ),
            const SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Effective Date"),
                    const SizedBox(height: 8,),
                    Text(DateFormat('dd MMM y').format(DateTime.parse(shiftDetail.data?.effectiveDate ?? '0000-00-00')), style: const TextStyle(fontWeight: FontWeight.bold),)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 44),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("To Schedule"),
                      const SizedBox(height: 8,),
                      Text('${shiftDetail.data?.newShiftName} ${shiftDetail.data?.newShiftScheduleIn} - ${shiftDetail.data?.newShiftScheduleOut}', style: const TextStyle(fontWeight: FontWeight.bold),)
                    ],
                  ),
                )

              ],
            ),
            const SizedBox(height: 16,),
            const Text("Notes"),
            const SizedBox(height: 8,),
            Text(shiftDetail.data?.notes ?? '-', style: const TextStyle(fontWeight: FontWeight.bold),),
            const SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Tanggal Persetujuan"),
                if(shiftDetail.data?.status == 'APPROVED')(
                    Text(DateFormat('dd MMM y').format(DateTime.parse(shiftDetail.data?.approvedAt ?? '0000-00-00')), style: const TextStyle(fontWeight: FontWeight.bold),)
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
                children: (shiftDetail.data?.logsStatus ?? []).map((e) {
                  var index = shiftDetail.data?.logsStatus?.indexOf(e);

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
                              if((index!+1) != shiftDetail.data?.logsStatus?.length)(
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
            if(shiftDetail.data?.status == 'REQUEST')(
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: CButton(title: "Cancel Request",
                    loading: isLoadingCancelRequest,
                    enable: !isLoadingCancelRequest,
                    backgroundColor: const Color.fromARGB(255, 229, 234, 240),
                    textColor : const Color.fromARGB(255, 80, 80, 80),
                    onPressed: (){
                      cancelRequest(shiftDetail.data?.id ?? 0);
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
