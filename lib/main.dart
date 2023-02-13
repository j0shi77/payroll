import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:payroll_app/services/secure_storage.dart';
import 'package:payroll_app/view/attendance/attendance_list_page.dart';
import 'package:payroll_app/view/attendance/attendance_request.dart';
import 'package:payroll_app/view/attendance/attendance_request_detail_page.dart';
import 'package:payroll_app/view/menu/calendar_page.dart';
import 'package:payroll_app/view/overtime/overtime_detail_page.dart';
import 'package:payroll_app/view/overtime/overtime_list_page.dart';
import 'package:payroll_app/view/shift/shift_detail_page.dart';
import 'package:payroll_app/view/shift/shift_list_page.dart';
import 'package:payroll_app/view/shift/shift_request.dart';
import 'package:payroll_app/view/slip/slip_detail_page.dart';
import 'package:payroll_app/view/overtime/overtime_request.dart';
import 'package:payroll_app/view/splash_screen.dart';
import 'package:payroll_app/maps_demo.dart';
import 'package:payroll_app/view/attendance/attendance.dart';
import 'package:payroll_app/view/attendance/attendance_logs.dart';
import 'package:payroll_app/view/auth/login_screen.dart';
import 'package:payroll_app/view/dashboard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payroll_app/view/homepage.dart';
import 'package:payroll_app/view/inbox/inbox_detail_page.dart';
import 'package:payroll_app/view/inbox/inbox_page.dart';
import 'package:flutter/services.dart';
import 'package:payroll_app/view/time_off/balance_detail_page.dart';
import 'package:payroll_app/view/time_off/time_off_index.dart';
import 'package:payroll_app/view/time_off/time_off_request.dart';
import 'package:payroll_app/view/time_off/time_off_request_detail_page.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(
    const PayrollApp(),
  );
}

class PayrollApp extends StatefulWidget {
  const PayrollApp({Key? key}) : super(key: key);

  @override
  _PayrollSignInState createState() => _PayrollSignInState();

}

class _PayrollSignInState extends State<PayrollApp> {
  var isLogin;

  final SecureStorage secureStorage = SecureStorage();

  checkUserLoginState() async {
    var token = await secureStorage.readSecureData(key: 'token');
    if (token != '' && token != null) {
      setState(() {
        isLogin = true;
      });
    }else{
      setState(() {
        isLogin = false;
      });
    }
  }

  @override
  void initState() {

    var durasiSplash = const Duration(seconds: 5);

    Timer(durasiSplash, () {
      checkUserLoginState();
    });

    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payroll App',
      builder: (context, child) =>
          MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), child: child!),
      theme: ThemeData(
          inputDecorationTheme: const InputDecorationTheme(
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
            ),
            iconColor: Colors.grey,
            labelStyle: TextStyle(color: Color.fromARGB(255, 183, 183, 183)),
          ),
          primaryColor: const Color.fromARGB(255, 2, 82, 241),
          accentColor : const Color.fromARGB(255, 2, 82, 241),
          textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme)),
      home: isLogin != null
          ? isLogin
          ? const HomePage()
          : const LoginScreen()
          : const SplashScreenPage(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        SfGlobalLocalizations.delegate,
        MonthYearPickerLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('id', 'ID'),
      ],
      locale: const Locale('id'),
      routes: {
        '/homepage': (context) => const HomePage(),
        '/dashboard': (context) => const DashboardPage(),
        '/inbox': (context) => const InboxPage(),
        '/inbox/show': (context) => const InboxDetailPage(),
        '/maps-demo': (context) => const GoogleMapsDemo(),
        '/splash-screen': (context) => const SplashScreenPage(),
        '/attendance': (context) => const AttendancePage(),
        '/attendance/list': (context) => const AttendanceListPage(),
        '/attendance/detail': (context) => const AttendanceRequestDetailPage(),
        '/attendance/logs': (context) => const AttendanceLogsPage(),
        '/attendance/request': (context) => const AttendanceRequest(),
        '/menu/calendar': (context) => const CalendarPage(),
        '/overtime/request': (context) => const OvertimeRequest(),
        '/overtime/list': (context) => const OvertimePage(),
        '/overtime/detail': (context) => const OvertimeDetailPage(),
        '/slip/detail': (context) => const SlipDetailPage(),
        '/time_off/index': (context) => const TimeOffIndex(),
        '/time_off/request': (context) => const TimeOffRequest(),
        '/time_off/balance_detail': (context) => const BalanceDetailPage(),
        '/time_off/request_detail': (context) => const TimeOffRequestDetailPage(),
        '/shift/request': (context) => const ShiftRequest(),
        '/shift/list': (context) => const ShiftPage(),
        '/shift/detail': (context) => const ShiftDetailPage(),
      },
    );
  }
}
