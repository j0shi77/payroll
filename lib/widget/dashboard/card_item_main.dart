import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardItemMain extends StatelessWidget {
  final String path;
  final String title;
  final Color? svgColor;
  final String pathName;
  const CardItemMain(
      {Key? key,
      required this.path,
      required this.title,
      this.svgColor,
      required this.pathName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, pathName),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          direction: Axis.vertical,
          spacing: 10,
          children: [
            SvgPicture.asset(
              path,
              color: svgColor,
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 10),
            )
          ],
        ),
      ),
    );
  }
}
