import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:payroll_app/models/Announcement.dart';
import 'package:payroll_app/models/AnnouncementResponse.dart';
import 'package:payroll_app/models/TimeOffTypeList.dart';
import 'package:payroll_app/models/AccountResponse.dart';
import 'package:payroll_app/services/account_service.dart';
import 'package:payroll_app/services/announcement_service.dart';
import 'package:payroll_app/view/announcement/announcement_detail.dart';
import 'package:payroll_app/models/auth/current_user.dart';
import 'package:payroll_app/services/auth_service.dart';
import 'package:payroll_app/services/secure_storage.dart';
import 'package:payroll_app/widget/custom_alert.dart';

import 'package:payroll_app/widget/dashboard/card_item_header.dart';
import 'package:payroll_app/widget/dashboard/card_item_main.dart';

import '../helpers/Constant.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final SecureStorage secureStorage = SecureStorage();
  final AuthService _authService = AuthService();
  final AnnouncementService announcementService = AnnouncementService();



  List<Announcement> announcementList = [];

  String errAnnouncement = '',
      avatar = '',
      name = '',
      jobPosition = '',
      branchName = '';


  getCurrentUser() async {
    CurrentUser? currentUser;
    currentUser = await _authService.fetchCurrentUser();

    setState(() {
      avatar = '${baseUrl.replaceAll('api', 'image/')}${currentUser!.user!.avatar!}';
      name = currentUser.user!.name!;
      jobPosition = currentUser.jobPositionName!;
      branchName = currentUser.branchName!;
    });
  }

  getAnnouncement() async {
    AnnouncementResponse response = await announcementService.fetchAnnouncement();

    if(response.status == true){
      setState(() {
        announcementList = response.data ?? [];
      });
    }else {
      errAnnouncement = response.message ?? 'terjadi kesalahan saat mengambil data pengumuman';
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getAnnouncement();

    getCurrentUser();

  }

  @override
  Widget build(BuildContext context) {
    Size? size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 259,
              width: double.infinity,
              color: Colors.red,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(color: Theme.of(context).primaryColor,),
                  ),
                  Positioned(
                      top: 40,
                      bottom: 0,
                      right: 0,
                      left: 16,
                      child: Text("Cabang $branchName", style: const TextStyle(color: Colors.white),)
                  ),
                  Positioned(
                    top: 60,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            direction: Axis.horizontal,
                            spacing: 10,
                            crossAxisAlignment:
                            WrapCrossAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(avatar),
                              ),
                              Wrap(
                                direction: Axis.vertical,
                                spacing: 3,
                                children: [
                                  Text(
                                    name,
                                    style: const TextStyle(
                                        color: Color(0XFFFFFFFF),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    jobPosition,
                                    style: const TextStyle(
                                        color: Color(0XFFFFFFFF),
                                        fontSize: 12),
                                  ),

                                  // Text(token!)
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const Positioned(
                      top: 164,
                      bottom: 0,
                      right: 0,
                      left: 16,
                      child: Text("Pengajuan :", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
                  ),
                  Positioned(
                    top: 193,
                    bottom: 0,
                    right: 10,
                    left: 16,
                    child: SizedBox(
                      height: 100,
                      // height: ((size.height * 0.3) * 0.5) * 0.7,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Wrap(
                            direction: Axis.horizontal,
                            spacing: 16,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/attendance/request');
                                },
                                child: const CardItemHeader(
                                  title: "Absensi",
                                  svgPath: "assets/svgs/gis_location-poi-o.svg"
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/time_off/request');
                                },
                                child: const CardItemHeader(
                                  title: "TimeOff",
                                  svgPath: "assets/svgs/request_time_off.svg",
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/overtime/request');
                                },
                                child: const CardItemHeader(
                                  title: "Overtime",
                                  svgPath: "assets/svgs/request_overtime.svg",
                                ),
                              ),
                              InkWell(
                                onTap: () {

                                },
                                child: const CardItemHeader(
                                  title: "Reimbursement",
                                  svgPath: "assets/svgs/request_reimbursement.svg",
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: const Color.fromARGB(255, 229, 229, 229),
              width: double.infinity,
              height: size.height * 0.25,
              child: GridView(
                scrollDirection: Axis.horizontal,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  // childAspectRatio: 1,
                  // mainAxisExtent: 70
                ),
                children: const [
                  CardItemMain(
                    path:
                    "assets/svgs/fluent_task-list-square-rtl-24-filled.svg",
                    title: "Attendance",
                    pathName: '/attendance/list',
                  ),
                  CardItemMain(
                    path: "assets/svgs/fluent_clock-12-filled.svg",
                    title: "Overtime",
                    pathName: '/overtime/list',
                  ),
                  CardItemMain(
                    path: "assets/svgs/live_attendance.svg",
                    svgColor: Color(0XFF0FA958),
                    title: "Live Absen",
                    pathName: '/attendance',
                  ),
                  CardItemMain(
                    path: "assets/svgs/time_off.svg",
                    title: "TimeOff",
                    pathName: '/time_off/index',
                  ),
                  CardItemMain(
                    path: "assets/svgs/shift.svg",
                    title: "Shift",
                    pathName: '/shift/list',
                  ),
                  CardItemMain(
                    path: "assets/svgs/bi_calendar-date-fill.svg",
                    title: "Calendar",
                    pathName: '/menu/calendar',
                  ),
                  // CardItemMain(
                  //   path: "assets/svgs/majesticons_note-text.svg",
                  //   title: "Reimbursement",
                  //   pathName: '',
                  // ),
                  CardItemMain(
                    path: "assets/svgs/flat-color-icons_bookmark.svg",
                    title: "Slip Gaji",
                    pathName: '/slip/detail',
                  ),
                ],
              ),
            ),
            SizedBox(
              child: Container(
                color: const Color(0XFFFFFFFF),
                width: double.infinity,
                height: size.height * 0.43,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16, left: 16, top: 24, bottom: 24),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Pengumuman",
                            style: TextStyle(
                                color: Color(0XFF4684EB),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(padding: EdgeInsets.only(right: 7),
                            child:
                              Text(
                                "Lihat Lainnya",
                                style: TextStyle(
                                  color: Color(0XFF4684EB),
                                  fontSize: 10,
                                ),
                              ),
                          ),
                        ],
                      ),
                      Visibility(visible: errAnnouncement != '',
                          child: Column(
                            children: [
                              const SizedBox(height: 16,),
                              CustomAlert(type: 'warning', title: errAnnouncement),
                              const SizedBox(height: 16,),
                            ],
                          )
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: announcementList.length,
                          itemBuilder: (context, int index) {
                            return Container(
                              decoration: const BoxDecoration(
                                  border : Border(
                                      bottom: BorderSide(
                                          color:  Color(0XFFE5EAF0), width: 1)
                                  )
                              ),
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text(announcementList[index].announcementTitle!),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        settings: RouteSettings(arguments: announcementList[index]),
                                        builder: (context) =>
                                        const AnnouncementDetail()),
                                  );
                                },
                                trailing: Text(
                                    DateFormat("d MMMM yyyy", "id_ID")
                                        .format(DateTime.parse('${announcementList[index].announcementDate!} 00:00:00.000'))
                                ),
                              ),
                            );
                          }
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
