import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:payroll_app/models/Announcement.dart';
import 'package:payroll_app/widget/date-picker.dart';
import 'package:flutter_html/flutter_html.dart';

class AnnouncementDetail extends StatefulWidget {
  const AnnouncementDetail({Key? key}) : super(key: key);

  @override
  State<AnnouncementDetail> createState() => _AnnouncementDetailState();
}

class _AnnouncementDetailState extends State<AnnouncementDetail> {

  Future showDatetimePicker() {
    return showDialog<Widget>(
        context: context,
        builder: (BuildContext context) {
          return const CustomDatePicker();
        });
  }

  @override
  Widget build(BuildContext context) {
    //get parameters
    final arg = ModalRoute.of(context)!.settings.arguments as Announcement;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          iconSize: 32,
          onPressed: () {
             Navigator.pop(context);
          },
          icon: const Icon(Icons.chevron_left_outlined),
        ),
        flexibleSpace: Image.asset(
          'assets/images/bg_header_login.png',
          fit: BoxFit.cover,
        ),
        title: const Text("Detail Pengumuman"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Anang', style: TextStyle(fontWeight: FontWeight.bold),),
            Text('Diposting pada ${DateFormat("d MMMM yyyy", "id_ID")
                .format(DateTime.parse('${arg.announcementDate!} 00:00:00.000'))}', style: const TextStyle(fontWeight: FontWeight.normal)),
            const SizedBox(height: 16),
            Text(arg.announcementTitle!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
            const SizedBox(height: 16),
            Html(
                style : {
                  "body": Style(
                    padding: EdgeInsets.zero,
                    margin: Margins(
                      bottom: Margin.zero(),
                      left: Margin.zero(),
                      top: Margin.zero(),
                      right: Margin.zero(),
                    )
                  )
                },
                data: arg.announcement)
          ],
        ),
      ),
    );
  }
}
