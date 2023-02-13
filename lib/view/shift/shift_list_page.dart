import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:payroll_app/widget/button_custom.dart';
import 'package:intl/intl.dart';
import 'package:payroll_app/widget/date-picker.dart';

import '../../models/ShiftList.dart';
import '../../services/shift_service.dart';

class ShiftPage extends StatefulWidget {
  const ShiftPage({Key? key}) : super(key: key);

  @override
  State<ShiftPage> createState() => _ShiftPageState();
}

class _ShiftPageState extends State<ShiftPage> {

  DateTime? month;
  List<Data> shiftList = [];
  bool isLoading = false;
  final shiftService = ShiftService();

  Future showDatetimePicker() {
    return showDialog<Widget>(
      context: context,
      builder: (BuildContext context) {
        return const CustomDatePicker();
    });
  }

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
    ShiftList response =  await shiftService.fetchShiftList(DateFormat('yyyy-MM').format(month ?? DateTime.now()).toString());
    if(response.status == 200){
      setState(() {
        isLoading = false;
        shiftList = response.data!;
      });
    }else{

    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      isLoading = true;
    });

    getList();
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
        title: const Text("Shift"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          children: [
            InkWell(
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
            const SizedBox(height: 16,),
            if(isLoading) const LinearProgressIndicator(),
            if(shiftList.isEmpty && !isLoading) const Text("No data avalilable"),
            Expanded(
              child: ListView(
                children: shiftList.map((e) =>
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, '/shift/detail', arguments: {'id' : e.id});
                      },
                      child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(DateFormat('dd MMM y').format(DateTime.parse(e.date!)), style: const TextStyle(fontWeight: FontWeight.bold),),
                                    const SizedBox(height: 4,),
                                    Text("To ${e.newShiftName} (${e.scheduleIn} - ${e.scheduleOut})",
                                    )
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
                                    Navigator.pushNamed(context, '/overtime/detail', arguments: {'id' : e.id});
                                  },
                                  icon: const Icon(Icons.chevron_right),
                                )
                            )
                          ]
                      ),
                    )).toList(),
              ),
            ),
            CButton(title: "Request Shift", onPressed: (){
              Navigator.pushNamed(context, '/shift/request');
            })
          ],
        ),
      )
    );
  }
}
