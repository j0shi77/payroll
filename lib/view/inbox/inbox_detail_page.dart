import 'package:flutter/material.dart';

class InboxDetailPage extends StatefulWidget {
  const InboxDetailPage({Key? key}) : super(key: key);

  @override
  State<InboxDetailPage> createState() => _InboxDetailPageState();
}

class _InboxDetailPageState extends State<InboxDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detail Inbox",
          style: TextStyle(fontSize: 16),
        ),
        centerTitle: true,
        flexibleSpace: FlexibleSpaceBar(
          background: SafeArea(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/bg_header_login.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: const [
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            leading: CircleAvatar(
                backgroundImage: AssetImage('assets/images/avatar_img.png')),
            title: Text("Mr. Edwards"),
            subtitle: Text("Head Recruter"),
            trailing: Text("20/06/2022"),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
                "Hello everyone we have announcement this week. We will maintainance this App,Sorry for have problems. We will fixing as soon as possible, Thank for patient. "),
          ),
        ],
      ),
    );
  }
}
