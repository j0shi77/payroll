import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:payroll_app/helpers/Constant.dart';
import 'package:payroll_app/models/SlipDetail.dart';
import 'package:payroll_app/services/other_service.dart';
import 'package:payroll_app/services/slip_service.dart';
import 'package:payroll_app/widget/button_custom.dart';
import 'package:payroll_app/widget/date-picker.dart';
import 'package:payroll_app/widget/form_custom.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../models/auth/current_user.dart';
import '../../services/auth_service.dart';
import '../../services/secure_storage.dart';

//global var
final OtherService otherService = OtherService();
final editPassword = TextEditingController();
bool isAuthenticated = false;

class SlipDetailPage extends StatefulWidget {
  const SlipDetailPage({Key? key}) : super(key: key);

  @override
  State<SlipDetailPage> createState() => SlipDetailPageState();
}

class SlipDetailPageState extends State<SlipDetailPage> {
  bool showWidget = false, downloading = false;
  DateTime? month;
  final AuthService _authService = AuthService();

  final slipService = SlipService();

  final storage = SecureStorage();
  String name = '', jobPosition = '', message = '', token = '';
  Data slipDetail = Data();
  final NumberFormat currency = NumberFormat('#,##0', 'id_ID');
  num totalAllowance = 0, totalDeduction = 0, totalBenefits = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showModalPassword();
    });

    getCurrentUser();

    setToken();

  }

  Future setToken() async {
    token = await storage.readSecureData(key: 'token');
  }

  Future showDatetimePicker() {
    return showDialog<Widget>(
        context: context,
        builder: (BuildContext context) {
          return const CustomDatePicker();
        });
  }

  getCurrentUser() async {
    CurrentUser? currentUser;
    currentUser = await _authService.fetchCurrentUser();

    setState(() {
      name = currentUser!.user!.name!;
      jobPosition = currentUser.jobPositionName!;
    });
  }

  getSlipDetail() async {
    SlipDetail response = await slipService.fetchSlipDetail(DateFormat('y-MM').format(month ?? DateTime.now()));

    setState(() {
      message = response.message!;
    });

    if(response.status == 200){

      setState(() {
        slipDetail = response.data!;

        //count total Allowance
        num tempTotalAllowance = 0;
        for(var i=0;i<(slipDetail.allowance ?? []).length;i++){
          tempTotalAllowance += slipDetail.allowance?[i].amount ?? 0;
        }

        totalAllowance = tempTotalAllowance;

        //count total deduction
        num tempTotalDeduction = 0;
        for(var i=0;i<(slipDetail.deduction ?? []).length;i++){
          tempTotalDeduction += slipDetail.deduction?[i].amount ?? 0;
        }

        totalDeduction = tempTotalDeduction;

        //count total benefits
        num tempTotalBenefit = 0;
        for(var i=0;i<(slipDetail.benefits ?? []).length;i++){
          tempTotalBenefit += slipDetail.benefits?[i].amount ?? 0;
        }

        totalBenefits = tempTotalBenefit;

      });
    }else{

    }
  }

  downloadPaySlip() async {

    print("token $token");

    setState(() {
      downloading = true;
    });
    String monthTmp = DateFormat('y-MM').format(month ?? DateTime.now());
    String fileurl = "$baseUrl/slip/download?month=$monthTmp";
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      //add more permission to request here.
    ].request();

    if(statuses[Permission.storage]!.isGranted){
      var dir = await getApplicationDocumentsDirectory();

      String saveName = "payslip-$monthTmp.pdf";
      String savePath = "${dir.path}/$saveName";
      print(savePath);
      //output:  /storage/emulated/0/Download/banner.png

      try {
        await Dio().download(
          fileurl,
          savePath,
          options: Options(headers: {'Authorization': 'Bearer $token'}),
          onReceiveProgress: (received, total) {
            if (total != -1) {
              print("${(received / total * 100).toStringAsFixed(0)}%");
              //you can build progressbar feature too
            }
          },
          deleteOnError: true,);

        showSnackBar("File is saved to download folder.", true, savePath);
      } on DioError catch (e) {
        print(e.message);

        showSnackBar("File is failed to download folder.", false, '');
      }

      setState(() {
        downloading = false;
      });
    }else{

      showSnackBar("No permission to read and write.", false, '');

      setState(() {
        downloading = false;
      });
    }
  }

  showSnackBar(String message, bool isSuccess, String fileLocation){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: isSuccess?5:3),
        action: SnackBarAction(
          label: isSuccess?'Open File':'Close',
          onPressed: () {
            // Code to execute.
            if(isSuccess){
              OpenFile.open(fileLocation);
            }
          },
        ),
      ),
    );
  }

  showModalPassword() {
    Future future = showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      context: context,
      builder: (_) => BottomSheetPassword(getSlipDetail: getSlipDetail),
    );

    future.then((value) {
      if(!isAuthenticated){
        Navigator.pop(context);
      }
    });
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

      getSlipDetail();
    }
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
      title: const Text("My Payslip"),
      centerTitle: true,
      elevation: 0,
    ),
    body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
            children: [
              SizedBox(
                height: 250,
                width: double.infinity,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(color: Theme.of(context).primaryColor,),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 15, top: 40),
                      child: InkWell(
                        onTap: () => monthPicker(context: context, locale: 'id'),
                        child: Card(
                          elevation: 0,
                          margin: EdgeInsets.zero,
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            title: Text(DateFormat("MMMM yyyy", "id_ID").format(month ?? DateTime.now())),
                            trailing: const FaIcon(FontAwesomeIcons.angleDown,color: Color.fromARGB(
                                255, 105, 155, 247)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 110,
                        right: 16,
                        left: 16,
                        bottom: 0,
                      ),
                      child: SizedBox(
                        height: 125,
                        child: Card(
                          shadowColor: const Color.fromARGB(126, 255, 255, 255),
                          margin: EdgeInsets.zero,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  child: Text(
                                    '*CONFIDENTIAL',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Color.fromARGB(255, 237, 16, 0)),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Divider(height: 1,),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          name,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: Color(0XFF303030),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 8,),
                                        Text(
                                          jobPosition,
                                          style: const TextStyle(
                                              color: Color(0XFFABABAB)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              if(message.contains("No data"))(
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Text("Payslip ${DateFormat("MMMM yyyy", "id_ID").format(month ?? DateTime.now())} Not Available", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),),
                )
              )else(

                Column(
                  children: [

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: Column(
                        children: [
                          Card(
                            elevation: 2,
                            margin: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              children: [
                                ListTile(
                                  trailing: SvgPicture.asset(
                                    'assets/svgs/earnings.svg',
                                    width: 18.0,
                                    height: 18.0,
                                  ),
                                  title: const Text('Allowance', style: TextStyle(color: clGreen, fontSize: 18),),
                                ),
                                const Divider(height: 1,color: clGreen,),
                                Column(
                                  children: (slipDetail.allowance??[]).map((e) {
                                    return ListTile(
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
                                      title: Text(e.component??'', style: const TextStyle(color: Color.fromARGB(255, 112, 112, 112), fontSize: 14),),
                                      trailing: Text("Rp ${currency.format(e.amount)}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                                    );
                                  }).toList()
                                ),
                                ListTile(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5))),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
                                  title: const Text('Total Allowances', style: TextStyle(color: Color.fromARGB(255, 112, 112, 112), fontWeight: FontWeight.bold),),
                                  trailing: Text("Rp ${currency.format(totalAllowance)}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                                  tileColor: clGreen2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: Column(
                        children: [
                          Card(
                            elevation: 2,
                            margin: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              children: [
                                ListTile(
                                  trailing: SvgPicture.asset(
                                    'assets/svgs/deductions.svg',
                                    width: 18.0,
                                    height: 18.0,
                                  ),
                                  title: const Text('Deductions', style: TextStyle(color: clRed, fontSize: 18),),
                                ),
                                const Divider(height: 1, color: clRed,),
                                Column(
                                  children: (slipDetail.deduction ?? []).map((e) {
                                    return ListTile(
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
                                      title: Text(e.component??'', style: const TextStyle(color: Color.fromARGB(255, 112, 112, 112), fontSize: 14),),
                                      trailing: Text("Rp ${currency.format(e.amount??0)}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                                    );
                                  }).toList(),
                                ),
                                ListTile(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5))),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
                                  title: const Text('Total Deduction', style: TextStyle(color: Color.fromARGB(255, 112, 112, 112), fontWeight: FontWeight.bold),),
                                  trailing: Text("Rp ${currency.format(totalDeduction)}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                                  tileColor: clRed2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      child: Card(
                        color: clBlue2,
                        elevation: 0,
                        margin: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              children: [
                                const Text("Take Home Pay", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                                const SizedBox(height: 10,),
                                Text("Rp ${currency.format(slipDetail.netPayble??0)}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: clBlue),)
                              ],
                            )
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: Column(
                        children: [
                          Card(
                            elevation: 2,
                            margin: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              children: [
                                ListTile(
                                  trailing: SvgPicture.asset(
                                    'assets/svgs/earnings.svg',
                                    width: 18.0,
                                    height: 18.0,
                                  ),
                                  title: const Text('Benefit', style: TextStyle(color: clGreen, fontSize: 18),),
                                ),
                                const Divider(height: 1,color: clGreen,),
                                Column(
                                    children: (slipDetail.benefits??[]).map((e) {
                                      return ListTile(
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
                                        title: Text(e.component??'', style: const TextStyle(color: Color.fromARGB(255, 112, 112, 112), fontSize: 14),),
                                        trailing: Text("Rp ${currency.format(e.amount)}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                                      );
                                    }).toList()
                                ),
                                ListTile(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5))),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
                                  title: const Text('Total Benefits', style: TextStyle(color: Color.fromARGB(255, 112, 112, 112), fontWeight: FontWeight.bold),),
                                  trailing: Text("Rp ${currency.format(totalBenefits)}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                                  tileColor: clGreen2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: Column(
                        children: [
                          Card(
                            elevation: 2,
                            margin: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              children: [
                                const ListTile(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5))),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 0),
                                  title: Text('Attendance Summary*', style: TextStyle(color: Color.fromARGB(255, 112, 112, 112), fontWeight: FontWeight.bold),),
                                  tileColor: clGray2,
                                ),
                                Column(
                                  children: (slipDetail.attendanceSummary ?? []).map((e)  {
                                    return ListTile(
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
                                    title: Text((e.component ?? '').replaceAll("_", " ").toTitleCase(), style: const TextStyle( fontSize: 14),),
                                    trailing: Text(e.amount.toString(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: CButtonBordered(
                        title: "Download Payslip ${DateFormat('MMMM y', 'id_ID').format(month ?? DateTime.now())}",
                        onPressed: (){
                          downloadPaySlip();
                        },
                        enable: !downloading,
                        loading: downloading,
                        textColor: Theme.of(context).primaryColor,
                      ),
                    )

                  ],
                )

              ),
            ],
          )
      )
    );
  }

}

class BottomSheetPassword extends StatefulWidget {
  const BottomSheetPassword({super.key, this.getSlipDetail});

  final Function? getSlipDetail;

  @override
  State<BottomSheetPassword> createState() => _BottomSheetPasswordState();
}

class _BottomSheetPasswordState extends State<BottomSheetPassword> {
  bool isLoadingCheckPassword = false;
  String errorPassword = '';

  Future checkPassword() async{
    setState(() {
      isLoadingCheckPassword = true;
    });
    var response = await otherService.fetchCheckPassword(editPassword.text);
    if(response.status == 200){

      setState(() {
        errorPassword = '';
        isAuthenticated = true;
      });

      //load slip
      widget.getSlipDetail!();

      //clear form
      editPassword.text = '';

      //close modal password
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) return;
      Navigator.pop(context);

    }else{
      setState(() {
        isAuthenticated = false;
        errorPassword = response.message ?? 'Terjadi kesalahan saat check password';
      });
    }

    setState(() {
      isLoadingCheckPassword = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          height: 220,
          color: const Color.fromARGB(255, 255, 255, 255),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:  const [
                    Text("Masukan Password"),
                  ],
                ),
              ),
              FormCustomBg(
                controller: editPassword,
                helpText: "Ketikan sandi...",
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(errorPassword, style: const TextStyle(color: clRed),),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: CButton(title: "Kirim", enable: !isLoadingCheckPassword, loading: isLoadingCheckPassword, onPressed: (){
                  checkPassword();
                }),
              ),
            ],
          ),
        )
    );
  }
}

extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}
