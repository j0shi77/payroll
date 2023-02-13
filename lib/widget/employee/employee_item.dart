import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payroll_app/helpers/Constant.dart';
import 'package:payroll_app/models/EmployeeList.dart';
import 'package:url_launcher/url_launcher.dart';

class EmployeeItem extends StatelessWidget {
  const EmployeeItem(this.index, this.employeeList, {Key? key}) : super(key: key);

  final int index;
  final List<Data> employeeList;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      shape: const Border(bottom: BorderSide(color: Color(0XFFECECEC), width: 1)),
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: NetworkImage('${baseUrl.replaceAll('api', 'image/')}${employeeList[index].avatar ?? ''}'),
      ),
      title: Text(employeeList[index].fullName!),
      subtitle: Text(employeeList[index].jobPositionName ?? ''),
      trailing: Wrap(
        spacing: 8,
        children: [
          InkWell(
            onLongPress: () async {
              String url = '';
              if (Platform.isAndroid) {
                // add the [https]
                url = "https://wa.me/${employeeList[index].mobilePhone}/?text=Hallo ${employeeList[index].fullName}!"; // new line
              } else {
                // add the [https]
                url = "https://api.whatsapp.com/send?phone=${employeeList[index].mobilePhone}=Hallo ${employeeList[index].fullName}!"; // new line
              }

              // android , web
              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(Uri.parse(url));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Whatsapp not installed")));
              }
            },
            child: const Icon(
              FontAwesomeIcons.whatsappSquare,
              size: 18,
              color: Color(0XFF0ABB87),
            )
          ),

          InkWell(
              onLongPress: () async {
                final call = Uri.parse('tel:${employeeList[index].mobilePhone}');
                if (await canLaunchUrl(call)) {
                  launchUrl(call);
                } else {
                  SnackBar(content: Text('Could not launch $call'));
                }
              },
              child: const FaIcon(
                FontAwesomeIcons.squarePhone,
                size: 18,
                color: Color(0XFF407BFF),
              )
          ),

          InkWell(
              onLongPress: () async {
                String? encodeQueryParameters(Map<String, String> params) {
                  return params.entries
                      .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                      .join('&');
                }

                final Uri emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: employeeList[index].email,
                  query: encodeQueryParameters(<String, String>{
                    'subject': 'Hallo ${employeeList[index].fullName}!'
                  }),
                );

                launchUrl(emailLaunchUri);
              },
              child: const FaIcon(
                FontAwesomeIcons.solidEnvelope,
                size: 18,
                color: Color(0XFF717171),
              )
          )
        ],
      ),
    );
  }
}
