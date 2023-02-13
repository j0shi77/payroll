
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:payroll_app/helpers/Constant.dart';
import 'package:payroll_app/models/TimeOffBalanceDetail.dart';
import 'package:payroll_app/services/time_off_service.dart';

class BalanceDetailPage extends StatefulWidget {
  const BalanceDetailPage({Key? key}) : super(key: key);

  @override
  State<BalanceDetailPage> createState() => _BalanceDetailPageState();
}

class _BalanceDetailPageState extends State<BalanceDetailPage> {

  DateTime? year;

  final TimeOffService announcementService = TimeOffService();

  final scheduleOutController = TextEditingController();

  TimeOffBalanceDetail timeOffBalanceDetail = TimeOffBalanceDetail();

  bool isLoading = false;

  num totalCarryForward = 0;
  num totalAdjustment   = 0;
  num totalExpired      = 0;

  getBalanceDetail(String year) async {
    var response = await announcementService.fetchBalanceDetail(year);

    if(response.status == 200){

      num tmpTotalCarryForward = 0;
      num tmpTotalAdjustment = 0;
      num tmpTotalExpired = 0;

      try{
        for(var i = 0;i < (response.data?.carryForward ?? []).length ;i++){
          tmpTotalCarryForward += (response.data?.carryForward ?? [])[i].value ?? 0;
        }

        for(var i = 0;i < (response.data?.adjustment ?? []).length ;i++){
          tmpTotalAdjustment += (response.data?.adjustment ?? [])[i].value ?? 0;
        }

        for(var i = 0;i < (response.data?.expired ?? []).length ;i++){
          tmpTotalExpired += (response.data?.expired ?? [])[i].value ?? 0;
        }

      }catch(e){
        print('Error $e');
      }

      setState(() {
        timeOffBalanceDetail = response;
        isLoading         = false;
        totalExpired      = tmpTotalExpired;
        totalCarryForward = tmpTotalCarryForward;
        totalAdjustment   = tmpTotalAdjustment;
      });

    }else {
      showSnackBar(response.message ?? '');
    }
  }

  yearPicker() async {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Year"),
          content: SizedBox( // Need to use container to add size constraint.
            width: 300,
            height: 300,
            child: YearPicker(
              firstDate: DateTime(DateTime.now().year - 10, 1),
              lastDate: DateTime(DateTime.now().year + 10, 1),
              initialDate: DateTime.now(),
              // save the selected date to _selectedDate DateTime variable.
              // It's used to set the previous selected date when
              // re-showing the dialog.
              selectedDate: year ?? DateTime.now(),
              onChanged: (DateTime dateTime) {

                setState(() {
                  year = dateTime;

                  isLoading = true;
                });

                getBalanceDetail(year?.year.toString() ?? '');

                // close the dialog when year is selected.
                Navigator.pop(context);

                // Do something with the dateTime selected.
                // Remember that you need to use dateTime.year to get the year
              },
            ),
          ),
        );
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

    getBalanceDetail(year?.year.toString() ?? DateTime.now().year.toString());
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          iconSize: 32,
          onPressed: () {
             Navigator.pop(context);
          },
          icon: const Icon(Icons.chevron_left_outlined),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Balance Detail"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 150,
          ),
          child: Container(
            // height: 600,
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: yearPicker,
                  child: Card(
                    elevation: 0,
                    margin: const EdgeInsets.only(left: 16, right: 16),
                    child: ListTile(
                      minLeadingWidth : 0,
                      contentPadding: const EdgeInsets.only(left: 16, right: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: const BorderSide(width: 1, color: Color.fromARGB(
                            255, 159, 159, 159)),
                      ),
                      title: Text(
                          (year != null)?
                          DateFormat("yyyy", "id_ID").format(year!)
                              : DateTime.now().year.toString()
                      ),
                      leading: const FaIcon(FontAwesomeIcons.calendar),
                      trailing: const FaIcon(FontAwesomeIcons.caretDown),
                    ),
                  ),
                ),

                if(isLoading)(
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: LinearProgressIndicator(),
                    )
                ),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox( height: 16,),
                      const Text("Cuti Tahunan", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                      const SizedBox( height: 16,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Until"),
                                const SizedBox( height: 8,),
                                Text(timeOffBalanceDetail.data?.beginning?.startDate ?? '', style: const TextStyle(fontWeight: FontWeight.bold),)
                              ],
                            ),
                          ),
                          const SizedBox(width:16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Remaining"),
                                const SizedBox( height: 8,),
                                Text("${timeOffBalanceDetail.data?.remaining?.remaining ?? 0} Day${(timeOffBalanceDetail.data?.remaining?.remaining ?? 0) >0?'s':''}", style: const TextStyle(fontWeight: FontWeight.bold, color: clGreen),)
                              ],
                            ),
                          ),
                          const SizedBox(width:16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Taken"),
                                const SizedBox( height: 8,),
                                Text("${timeOffBalanceDetail.data?.remaining?.takenValue ?? 0} Day${(timeOffBalanceDetail.data?.remaining?.takenValue ?? 0) >0?'s':''}", style: const TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(
                                    255, 255, 37, 37)),)
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  )
                ),
                const SizedBox(height:16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
                  margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color.fromARGB(
                        255, 243, 243, 243)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Beginning"),
                      Text("${timeOffBalanceDetail.data?.beginning?.value ?? 0}", style: const TextStyle(fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color.fromARGB(
                          255, 243, 243, 243)
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Adjustment"),
                          Text(totalAdjustment.toString() ?? '', style: const TextStyle(color: clGreen),)
                        ],
                      ),
                      const SizedBox(height: 8,),
                      const Divider(height: 1,),
                      Column(
                        children: (timeOffBalanceDetail.data?.adjustment ?? []).map((e) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Generate By ${e.generateBy}"),
                                  const SizedBox(height: 4,),
                                  Row(
                                    children: [
                                      Text("On ${DateFormat('DD MMM y').format(DateTime.parse(e.startDate??''))} Expiry On ", style: const TextStyle(color: Color.fromARGB(255, 162, 166, 166)),), Text(DateFormat('DD MMM y').format(DateTime.parse(e.endDate??'')))],
                                  )
                                ],
                              ),
                              Text(e.value.toString(), style: const TextStyle(color: clGreen),)
                            ],
                          ),
                        )).toList(),
                      )
                    ],
                  )
                ),

                const SizedBox(height: 16,),
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color.fromARGB(
                            255, 243, 243, 243)
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Time Off Taken"),
                            Text((timeOffBalanceDetail.data?.remaining?.takenValue ?? 0).toString() ?? '', style: const TextStyle(color: clRed),)
                          ],
                        ),
                        const SizedBox(height: 8,),
                        const Divider(height: 1,),
                        Column(
                          children: (timeOffBalanceDetail.data?.timeOffTaken ?? []).map((e) =>
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${DateFormat('d MMM y').format(DateTime.parse(e.startDate??''))} ${e.endDate != null && (e.startDate != e.endDate)? 'to ${DateFormat('d MMM y').format(DateTime.parse(e.endDate??''))}' : ''}"),
                                        const SizedBox(height: 4,),
                                        Text(e.note??'', style: const TextStyle(color: Color.fromARGB(
                                            255, 162, 166, 166)),)
                                      ],
                                    ),
                                    Text(e.value.toString(), style: const TextStyle(color: clRed),)
                                  ],
                                ),
                              )
                          ).toList()
                        )
                      ],
                    )
                ),

                const SizedBox(height: 16,),
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color.fromARGB(
                            255, 243, 243, 243)
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Carry Forward"),
                            Text(totalCarryForward.toString() ?? '', style: const TextStyle(color: clGreen),)
                          ],
                        ),
                        const SizedBox(height: 8,),
                        const Divider(height: 1,),
                        Column(
                          children: (timeOffBalanceDetail.data?.carryForward ?? []).map((e)=> Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Unused Balance'),
                                    const SizedBox(height: 4,),
                                    Row(
                                      children: [Text("On ${DateFormat('DD MMM y').format(DateTime.parse(e.startDate??''))} Expiry On ", style: const TextStyle(color: Color.fromARGB(
                                          255, 162, 166, 166)),), Text(DateFormat('DD MMM y').format(DateTime.parse(e.endDate??'')))],
                                    )
                                  ],
                                ),
                                Text(e.value.toString(), style: const TextStyle(color: clGreen),)
                              ],
                            ),
                          )).toList()
                        )
                      ],
                    )
                ),

                const SizedBox(height: 16,),
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color.fromARGB(
                            255, 243, 243, 243)
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Expired"),
                             Text(totalExpired.toString(), style: const TextStyle(color: clRed),)
                          ],
                        ),
                        const SizedBox(height: 8,),
                        const Divider(height: 1,),
                        Column(
                          children: ( timeOffBalanceDetail.data?.expired ?? [] ).map((e) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(DateFormat('DD MMM y').format(DateTime.parse(e.expiredAt??''))),
                                    const SizedBox(height: 4,),
                                    Text(e.timeOffDsc??'', style: const TextStyle(color: Color.fromARGB(
                                        255, 162, 166, 166)),)
                                  ],
                                ),
                                Text(e.value.toString(), style: const TextStyle(color: clRed),)
                              ],
                            ),
                          )).toList(),
                        )
                      ],
                    )
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
