import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardItemHeader extends StatelessWidget {
  final String title;
  final String svgPath;
  const CardItemHeader(
      {Key? key,
      required this.title,
      required this.svgPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Card(
        color: const Color(0XFFFFFFFF),
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.asset(
                svgPath,
                width: 18.0,
                height: 18.0,
              ),
              const SizedBox(width: 11,),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        )
      ),
    );
  }
}
