import 'package:flutter/material.dart';

class ProfileAppbar extends StatelessWidget {
  const ProfileAppbar({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 200,
          child: AppBar(
              elevation: 0,
              title: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              flexibleSpace: Stack(
                children: [
                  Positioned.fill(
                      child: Image.asset(
                    'assets/images/bg_profile.png',
                    fit: BoxFit.fill,
                  ))
                ],
              ),
              centerTitle: true,
              leading: IconButton(
                iconSize: 32,
                icon: const Icon(Icons.chevron_left_rounded),
                onPressed: () {
                  Navigator.pop(context);
                },
              )),
        )
      ],
    );
  }
}
