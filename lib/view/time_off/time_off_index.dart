import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:payroll_app/models/TimeOffRequestList.dart';
import 'package:payroll_app/widget/button_custom.dart';
import 'package:payroll_app/widget/custom_appbar.dart';
import 'package:intl/intl.dart';

import '../../models/TimeOffBalanceDetail.dart' hide Data;
import '../../services/time_off_service.dart';

class TimeOffIndex extends StatefulWidget {
  const TimeOffIndex({Key? key}) : super(key: key);

  @override
  State<TimeOffIndex> createState() => _TimeOffIndexState();
}

class _TimeOffIndexState extends State<TimeOffIndex> {

  DateTime? month;
  List<Data> list = [];
  bool isLoading = false, isLoadingBalance = false;

  final timeOffService = TimeOffService();


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

      getList();
    });

  }

  getList() async {
    TimeOffRequestList response =  await timeOffService.fetchTimeOffRequestList(DateFormat('yyyy-MM').format(month ?? DateTime.now()).toString());
    if(response.status == 200){
      setState(() {
        isLoading = false;
        list = response.data!;
      });
    }else{
      setState(() {
        isLoading = false;
      });
    }
  }

  final TimeOffService announcementService = TimeOffService();
  TimeOffBalanceDetail timeOffBalanceDetail = TimeOffBalanceDetail();

  getBalanceDetail(String year) async {
    var response = await announcementService.fetchBalanceDetail(year);

    if(response.status == 200){
      setState(() {
        timeOffBalanceDetail = response;
        isLoadingBalance = false;
      });
    }else {

    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getList();

    setState(() {
      isLoadingBalance = true;
    });

    getBalanceDetail(DateTime.now().year.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          const SizedBox(
            height: 135,
            child: ProfileAppbar(
              title: "TimeOff",
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 80,
              right: 10,
              left: 10,
              bottom: 120,
            ),
            child: Container(
              width: double.infinity,
              child:  Card(
                shadowColor: Color.fromARGB(126, 255, 255, 255),
                elevation: 6,
                child: Container(
                  height: 102,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      children: [
                        Text("Cuti Tahunan"),
                        const SizedBox(height: 6,),
                        Text("${timeOffBalanceDetail.data?.remaining?.remaining ?? 0} Day${(timeOffBalanceDetail.data?.remaining?.remaining ?? 0) >0?'s':''}", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                        const SizedBox(height: 6,),
                        InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, '/time_off/balance_detail');
                          },
                          child: Text("View Detail", style: TextStyle(color: Theme.of(context).primaryColor),),
                        )
                      ],
                    ),
                  )
                )
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 209, left: 16, right: 16),
            child: InkWell(
              onTap: monthPicker,
              child: Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                child: ListTile(
                  minLeadingWidth : 0,
                  contentPadding: const EdgeInsets.only(left: 16, right: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: const BorderSide(width: 1, color: Color.fromARGB(
                        255, 159, 159, 159)),
                  ),
                  title: Text(
                      (month != null)?
                      DateFormat("MMMM yyyy", "id_ID").format(month!)
                          : 'Tanggal'
                  ),
                  leading: const FaIcon(FontAwesomeIcons.calendar),
                  trailing: const FaIcon(FontAwesomeIcons.caretDown),
                ),
              ),
            ),
          ),

          if(isLoading)(
              Container(
                margin: const EdgeInsets.only(top: 279),
                child: const LinearProgressIndicator(),
              )
          ),

          Container(
            margin: const EdgeInsets.only(bottom: 84, top: 279),
            child: ListView(
              children: list.map((e) =>
                  InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, '/time_off/request_detail', arguments: {'id' : e.id});
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(DateFormat('dd MMM y').format(DateTime.parse(e.date!)), style: const TextStyle(fontWeight: FontWeight.bold),),
                                    const SizedBox(height: 4,),
                                    Text(e.timeOffName ?? '',)
                                  ],
                                )
                            ),
                            Expanded(
                              flex: 0,
                              child: Card(
                                margin : const EdgeInsets.only(right: 80),
                                color: e.status == 'REQUEST'?
                                const Color.fromARGB(255, 245, 241, 241) : (e.status == 'PENDING'?
                                const Color.fromARGB(255, 255, 249, 228) : e.status == 'APPROVED'?
                                const Color.fromARGB(255, 237, 255, 251) : e.status == 'REJECTED'?
                                const Color.fromARGB(255, 255, 237, 237) :
                                const Color.fromARGB(255, 224, 227, 255)),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: Text(e.status!, style: TextStyle(fontSize: 12, color: e.status == 'REQUEST'?
                                  const Color.fromARGB(255, 162, 166, 166) : (e.status == 'PENDING'?
                                  const Color.fromARGB(255, 255, 199, 0) : e.status == 'APPROVED'?
                                  const Color.fromARGB(255, 0, 198, 150) : e.status == 'REJECTED'?
                                  const Color.fromARGB(255, 255, 37, 37) :
                                  const Color.fromARGB(255, 0, 5, 51))) ),
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 0,
                                child: IconButton(
                                  onPressed: (){
                                    Navigator.pushNamed(context, '/attendance/detail', arguments: {'id' : e.id});
                                  },
                                  icon: const Icon(Icons.chevron_right),
                                )
                            )
                          ]
                      ),
                    )
                  )).toList(),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: CButton(
                title: "Request Time Off", onPressed: () {
                  Navigator.of(context).pushNamed('/time_off/request');
                },
              ),
            )
          ),

        ],
      ),
    );
  }
}
