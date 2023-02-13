import 'package:flutter/material.dart';
import 'package:payroll_app/services/secure_storage.dart';
import 'package:payroll_app/view/account/account_main.dart';
import 'package:payroll_app/view/dashboard.dart';
import 'package:payroll_app/view/employee_page.dart';
import 'package:payroll_app/view/inbox/inbox_page.dart';
import 'package:payroll_app/widget/bottom_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _selectedIndex = 0;
  final PageController _pageController = PageController();

  final SecureStorage secureStorage = SecureStorage();

  Future<String> getToken() async {
    String token = await secureStorage.readSecureData(key: 'token');
    return token;
  }

  Future<void> checkToken() async {
    // String token = await getToken();

    // if (token != null) {
    //   Navigator.of(context).pushNamed('/dashboard');
    // } else {
    //   Navigator.of(context).pushNamed('/login');
    // }
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  final List<Widget> _screens = [
    const DashboardPage(),
    const EmployeePage(),
    const InboxPage(),
    const AccountPage(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: _screens,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
      ),
    );
  }
}
