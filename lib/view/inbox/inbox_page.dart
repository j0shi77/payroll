import 'package:flutter/material.dart';
import 'package:payroll_app/view/inbox/inbox_detail_page.dart';
import 'package:payroll_app/view/inbox/issue_approval_page.dart';
import 'package:payroll_app/view/inbox/notification_page.dart';

class InboxPage extends StatefulWidget {
  const InboxPage({Key? key}) : super(key: key);

  @override
  State<InboxPage> createState() => _InboxpageState();
}

class _InboxpageState extends State<InboxPage> {
  final List<Widget> _inboxScreens = [
    const NotificationPage(),
    const IssueApprovalPage(),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0XFFFFFFFF),
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text(
                  'Notifikasi',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Perlu Persetujuan",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          title: const Text(
            'Inbox',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          titleSpacing: -20,
        ),
        body: TabBarView(
          children: _inboxScreens,
        ),
      ),
    );
  }
}
