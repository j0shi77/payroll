import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payroll_app/models/CalendarResponse.dart';
import 'package:payroll_app/services/other_service.dart';
import 'package:payroll_app/widget/date-picker.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';




void main() => runApp(const CalendarPage());

const List<Widget> tabmenu = <Widget>[
  Text('Sedang Cuti'),
  Text('Ulang Tahun'),
  Text('Event')
];


class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      //ignore: always_specify_types
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        // ... app-specific localization delegate[s] here
        SfGlobalLocalizations.delegate
      ],
      //ignore: always_specify_types
      supportedLocales: [
        Locale('id'),
        // ... other locales the app supports
      ],
      locale: Locale('id'),
      home: CalendarVmenu(title: 'Kalender',),
    );
  }

}

class CalendarVmenu extends StatefulWidget {
  const CalendarVmenu({super.key, required this.title});

  final String title;

  @override
  State<CalendarVmenu> createState() => _ToggleButtonsSampleState();
}

class _ToggleButtonsSampleState extends State<CalendarVmenu> {
  final List<bool> _selectedTabMenu = <bool>[true, false, false];
  bool vertical = false;

  final otherService = OtherService();
  var indexSelected = 0;

  String month = '2023-01';

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
    var resp = await otherService.fetchCalendar(month);
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

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(iconSize: 32,
          onPressed: (){
            Navigator.of(context, rootNavigator: true).pop(context);
          },
          icon: const Icon(Icons.chevron_left_outlined),
        ),
        flexibleSpace: Image.asset(
          'assets/images/bg_header_login.png',
          fit: BoxFit.cover,
        ),
        title: const Text("Kalender"),
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
                    //call function
                    onTap: showDatetimePicker,
                    child: Card(
                      elevation: 0,
                      margin: EdgeInsets.zero,
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        tileColor: const Color.fromARGB(255, 229, 229, 229),
                        title: Text(DateFormat("MMM yyyy", "id_ID").format(DateTime.now())),
                        leading: const FaIcon(FontAwesomeIcons.solidCalendar),
                        trailing: const FaIcon(FontAwesomeIcons.caretDown),
                      ),
                    ),

                  ),

                ),
              ],
            ),
            SizedBox(height: 16,),
            Column(
              children: <Widget>[
                ToggleButtons(
                  renderBorder: false,
                  direction: vertical ? Axis.vertical : Axis.horizontal,
                  onPressed: (int index) {
                    indexSelected = index;
                    setState(() {
                      // The button that is tapped is set to true, and the others to false.
                      for (int i = 0; i < _selectedTabMenu.length; i++) {
                        _selectedTabMenu[i] = i == index;
                      }
                    });

                  },
                  borderRadius: BorderRadius.all(Radius.circular(150)),
                  selectedBorderColor: Colors.blue[700],
                  selectedColor: Colors.white,
                  fillColor: Colors.blueAccent[200],
                  color: Colors.blueAccent[400],
                  constraints: const BoxConstraints(
                    minHeight: 40.0,
                    minWidth: 100.0,
                  ),
                  isSelected: _selectedTabMenu,
                  children: tabmenu,
                ),
              ],
            ),

            SizedBox(height: 16,),
            if(indexSelected == 0)(
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
                          }).toList()
                      ),
                    ),
                  ),
                )
            ),

            if(indexSelected == 1)(
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

            if(indexSelected == 2)(
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
                          }).toList()
                      ),
                    ),
                  ),
                )
            )

          ],
        ),



      ),
    );
  }
}