
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payroll_app/helpers/Constant.dart';
import 'package:payroll_app/models/ShiftMaster.dart';
import 'package:payroll_app/services/attendance_service.dart';
import 'package:payroll_app/widget/button_custom.dart';
import 'package:payroll_app/widget/form_custom.dart';
import 'package:payroll_app/widget/date-picker.dart';
import 'package:intl/intl.dart';
import '../../services/secure_storage.dart';
import '../../services/shift_service.dart';

class ShiftRequest extends StatefulWidget {
  const ShiftRequest({Key? key}) : super(key: key);

  @override
  State<ShiftRequest> createState() => _ShiftRequestState();
}

class _ShiftRequestState extends State<ShiftRequest> {

  final editDate = TextEditingController();
  final editNotes = TextEditingController();
  final shiftService = ShiftService();
  final attendanceService = AttendanceService();
  String date = '', shiftName = '', scheduleIn = '', scheduleOut = '';
  bool enableBtnRequest = false, isLoading = false;

  final int maxFiles = 4;
  List<String> shiftMaster = [];
  List<Data> shiftMasterTmp = [];
  final SecureStorage secureStorage = SecureStorage();
  int? indexMasterSelected;

  Future showDatePicker() {
    return showDialog<Widget>(
      context: context,
      builder: (BuildContext context) {
        return CustomDatePicker(
          onSubmit: (val) async {
            setState(() {
              date = val.toString().substring(0,10);
            });

            editDate.text = DateFormat("dd MMMM yyyy", "id_ID").format(DateTime.parse(date));
            Navigator.pop(context);

            await getScheduleByDate();
          },
          initialSelectedDate: date.isEmpty?DateTime.now():DateTime.parse(date),
        );
      });
  }

  getScheduleByDate() async {
    var response = await attendanceService.fetchGetScheduleByDate(date);
    if(response.status == 200){
      setState(() {
        if(response.data != null){
          if(response.data?.showInRequest == 1){
            shiftName = response.data!.shiftName!;
            scheduleIn = response.data!.workingHourStart!;
            scheduleOut = response.data!.workingHourEnd!;
          }
          enableBtnRequest = true;
        }else{
          enableBtnRequest = false;
          showSnackBar(response.message!);
        }
      });
    }else{
      showSnackBar('get schedule by date has been failed, ${response.message!}');
    }
  }

  getShiftMaster() async {
    var response = await shiftService.fetchShiftMaster();
    if(response.status == 200){
      shiftMasterTmp = response.data!;

      setState(() {
        shiftMaster = (response.data ?? []).map((e) => "${e.name} (${e.scheduleIn} - ${e.scheduleOut})").toList();
      });
    }else{
      showSnackBar('get schedule by date has been failed, ${response.message!}');
    }
  }

  showSnackBar(String message){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: message.contains("success")?clBlue:clRed,
        action: SnackBarAction(
          label: 'Close',
          textColor: message.contains("success")?clGray2:clBlue,
          onPressed: () {
            // Code to execute.
          },
        ),
      ),
    );
  }

  requestShift() async {

    //dismiss keyboard
    FocusManager.instance.primaryFocus?.unfocus();

    //validation
    if(date == ''){
      showSnackBar("Gagal, Silakan isi tanggal");
      return;
    }

    if(indexMasterSelected == null){
      showSnackBar("Gagal, Silakan pilih shift baru yang diinginkan");
      return;
    }

    if(editNotes.text == ''){
      showSnackBar("Gagal, Silakan isi keterangan");
      return;
    }

    setState(() {
      isLoading = true;
    });

    var response = await shiftService.fetchRequest(date, shiftMasterTmp[indexMasterSelected??0].id.toString(), editNotes.text);

    if(response.status == 200){
      showSnackBar(response.message??'Ok');

      //clear form
      editNotes.text = '';
      editDate.text  = '';
      setState(() {
        indexMasterSelected = null;
        shiftName = '';
      });

    }else{
      showSnackBar(response.message??'Terjadi kesalahan saat request shift');
    }

    setState(() {
      isLoading = false;
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getShiftMaster();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          iconSize: 32,
          onPressed: () {
             Navigator.pop(context);
          },
          icon: const Icon(Icons.chevron_left_outlined),
        ),
        title: const Text("Request Shift"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 150,
          ),
          child: SizedBox(
            // height: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: FormIconCustom(
                      label: "Select Date",
                      icon: Icons.calendar_month,
                      controller: editDate,
                      readOnly: true,
                      onTap: showDatePicker,
                    ),
                ),
                if(shiftName != '')(
                    Column(
                      children: [
                        const SizedBox(height: 0),
                        Padding(
                          padding: const EdgeInsets.only(left: 64),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:  [
                                  const Text("Shift", style: TextStyle(color: Color.fromARGB(
                                      255, 162, 166, 166)),),
                                  const SizedBox(height: 8,),
                                  Text(shiftName)
                                ],
                              ),
                              const SizedBox(width: 16,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Schedule In", style: TextStyle(color: Color.fromARGB(
                                      255, 162, 166, 166)),),
                                  const SizedBox(height: 8,),
                                  Text(scheduleIn)
                                ],
                              ),
                              const SizedBox(width: 16,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Schedule Out", style: TextStyle(color: Color.fromARGB(
                                      255, 162, 166, 166)),),
                                  const SizedBox(height: 8,),
                                  Text(scheduleOut)
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    )

                ),

                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: OptionCustom(
                        labelText: "New Shift",
                        icon: FontAwesomeIcons.clock,
                        items: shiftMaster,
                        onChanged: (i){
                          setState(() {
                            indexMasterSelected = i;
                          });
                        }
                    )
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child:FormIconCustom(
                    label: "Keterangan",
                    icon: Icons.notes_rounded,
                    controller: editNotes,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    children: [
                      CButton(title: "Request Shift", loading: isLoading, enable: !isLoading && enableBtnRequest, onPressed: (){
                        if(!isLoading){
                          requestShift();
                        }
                      }),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
