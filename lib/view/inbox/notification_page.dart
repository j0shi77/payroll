import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificationPage extends StatefulWidget {
  static String pathName = "/inbox/show";
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: ListView.builder(
              itemCount: 100,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    debugPrint("text");
                    Navigator.of(context).pushNamed(NotificationPage.pathName);
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Color(0XFFECECEC), width: 1))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const CircleAvatar(
                                radius: 25,
                                backgroundImage:
                                    AssetImage('assets/images/avatar_img.png'),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Alex Maximillian",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0XFF303030),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Fullstack Developer",
                                    style: TextStyle(
                                        color: Color(0XFFABABAB), fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Wrap(
                            spacing: 10,
                            children: const [
                              FaIcon(
                                FontAwesomeIcons.angleRight,
                                size: 18,
                                color: Color(0XFF666666),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
