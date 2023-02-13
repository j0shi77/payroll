import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:payroll_app/models/CalendarResponse.dart';
import 'package:payroll_app/services/other_service.dart';
import 'package:payroll_app/widget/date-picker.dart';
import 'package:intl/intl.dart';

const List<Widget> tabmenu = <Widget>[
  Text('Sedang Cuti'),
  Text('Ulang Tahun'),
  Text('Event')
];

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});


  @override
  State<CalendarPage> createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {
  bool vertical = false;

  final otherService = OtherService();
  var indexSelected = 0;

  DateTime? month;

  // String month

  List<TimeOff> timeOff = [];
  List<BirthDay> birthDay = [];
  List<Event> event = [];

  Future showDatetimePicker() {
    return showDialog<Widget>(
        context: context,
        builder: (BuildContext context) {
          return const CustomDatePicker();
        });
  }


  getCalendarData () async {
    var resp = await otherService.fetchCalendar(DateFormat('y-MM').format(month ?? DateTime.now()));

    if(resp.status == 200){
      setState(() {
        timeOff = resp.data?.timeOff ?? [];
        birthDay = resp.data?.birthDay ?? [];
        event = resp.data?.event ?? [];
      });
    }else{
      //
    }
  }



  @override
  void initState() {
    super.initState();

    getCalendarData();

  }

  Future<void> monthPicker({ required BuildContext context, String? locale,}) async {
    final localeObj = locale != null ? Locale(locale) : null;
    final now = DateTime.now();
    final selected = await showMonthPicker(
      context: context,
      initialDate: month ?? DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(now.year, now.month + 1, now.day),
      locale: localeObj,
    );
    // final selected = await showDatePicker(
    //   context: context,
    //   initialDate: _selected ?? DateTime.now(),
    //   firstDate: DateTime(2019),
    //   lastDate: DateTime(2022),
    //   locale: localeObj,
    // );
    if (selected != null) {
      setState(() {
        month = selected;
      });

      getCalendarData();
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(iconSize: 32,
          onPressed: (){
            Navigator.of(context, rootNavigator: true).pop(context);
          },
          icon: const Icon(Icons.chevron_left_outlined),
        ),
        title: const Text("Kalender"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    //call function
                    onTap: () => monthPicker(context: context, locale: 'id'),
                    child: Card(
                      elevation: 0,
                      margin: EdgeInsets.zero,
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        tileColor: const Color.fromARGB(255, 229, 229, 229),
                        title: Text(DateFormat("MMMM yyyy", "id_ID").format(month ?? DateTime.now())),
                        trailing: const FaIcon(FontAwesomeIcons.angleDown,color: Color.fromARGB(
                            255, 105, 155, 247)),
                        leading: const FaIcon(FontAwesomeIcons.solidCalendar),
                      ),
                    ),

                  ),

                ),
              ],
            ),
            SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: tabmenu.map((e){

                int idx = tabmenu.indexOf(e);

                return Container(
                  width: 110,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                // side: BorderSide(color: Colors.blue),
                            ),
                        ),
                      backgroundColor: MaterialStateProperty.all<Color>(indexSelected == idx? Theme.of(context).primaryColor:Colors.grey),
                    ),
                    onPressed: (){
                      setState(() {
                        indexSelected = idx;
                      });
                    },
                    child : Center(
                      child: e,
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: 16,),
            if(indexSelected == 0 && timeOff.isNotEmpty)(
                Expanded(
                  child: SingleChildScrollView(
                    child: Card(
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: timeOff.map((e) {
                              return ListTile(
                                title:  Text("${e.fullName} - ${e.timeOffName}"),
                                subtitle: Text(DateFormat("DD MMM yyyy", "id_ID").format(DateTime.parse(e.date!)).toString()),
                              );
                          }
                          ).toList()
                      ),
                    ),
                  ),
                )
            ),

            if(indexSelected == 0 && timeOff.isEmpty)(
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("TimeOff ${DateFormat("MMMM yyyy", "id_ID").format(month ?? DateTime.now())} Not Available", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),),
                    ],
                  ),
                )
            ),



            if(indexSelected == 1 && birthDay.isNotEmpty)(
                Expanded(
                  child: SingleChildScrollView(
                    child: Card(
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: birthDay.map((e) {
                            return ListTile(
                              title:  Text("${e.fullName}"),
                              subtitle: Text(DateFormat("dd MMM yyyy", "id_ID").format(DateTime.parse(e.dateOfBirth!)).toString()),
                            );
                          }).toList()
                      ),
                    ),
                  ),
                )
            ),
            if(indexSelected == 1 && birthDay.isEmpty)(
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Birthday ${DateFormat("MMMM yyyy", "id_ID").format(month ?? DateTime.now())} Not Available", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),),
                    ],
                  ),
                )
            ),

                if(indexSelected == 2 && event.isNotEmpty)(
                Expanded(
                  child: SingleChildScrollView(
                    child: Card(
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: event.map((e) {
                            return ListTile(
                              title: Text(DateFormat("dd MMM yyyy", "id_ID").format(DateTime.parse(e.holidayDate!)).toString()),
                              subtitle: Text(e.holidayName ?? ""),
                            );
                          }
                          ).toList()
                      ),
                    ),
                  ),
                )
                ),

            if(indexSelected == 2 && event.isEmpty)(
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Event ${DateFormat("MMMM yyyy", "id_ID").format(month ?? DateTime.now())} Not Available", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),),
                    ],
                  ),
                )
            )

          ],
        ),



      ),
    );
  }
}