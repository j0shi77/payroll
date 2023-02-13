import 'package:flutter/material.dart';

class ButtonProfile extends StatelessWidget {
  const ButtonProfile({
    Key? key,
    required this.colour,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  final Color colour;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Material(
        color: colour,
        borderRadius: BorderRadius.circular(4),
        child: MaterialButton(
          // splashColor: Color.fromARGB(255, 239, 117, 117),
          animationDuration: const Duration(milliseconds: 1000),
          onPressed: onPressed,
          minWidth: double.infinity,
          height: 50,
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}


class CButton extends StatelessWidget{

  const CButton({
    Key? key,
    this.backgroundColor,
    required this.title,
    required this.onPressed,
    this.fontSize,
    this.height,
    this.minWidth,
    this.borderRadius,
    this.enable = true,
    this.loading = false,
    this.textColor
  }) : super(key: key);

  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final double? height;
  final double? minWidth;
  final String title;
  final VoidCallback onPressed;
  final double? borderRadius;
  final bool enable;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialButton(
      height: height ?? 50,
      minWidth: minWidth ?? double.infinity,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius??4)),
      onPressed: enable ? onPressed : null ,
      color: backgroundColor ?? Theme.of(context).primaryColor,
      disabledColor: Colors.black38,
      animationDuration: const Duration(milliseconds: 1000),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: fontSize ?? 14,
              color: textColor ?? Colors.white,
            ),
          ),
          if(loading) Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: textColor,
                strokeWidth: 3,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CButtonBordered extends StatelessWidget{

  const CButtonBordered({
    Key? key,
    this.backgroundColor,
    required this.title,
    required this.onPressed,
    this.fontSize,
    this.height,
    this.minWidth,
    this.borderRadius,
    this.enable = true,
    this.loading = false,
    this.textColor
  }) : super(key: key);

  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final double? height;
  final double? minWidth;
  final String title;
  final VoidCallback onPressed;
  final double? borderRadius;
  final bool enable;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialButton(
      height: height ?? 49,
      minWidth: minWidth ?? double.infinity,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius??4),
        side: BorderSide(color: textColor ?? Colors.white)
      ),
      onPressed: enable ? onPressed : null ,
      color: Colors.white,
      disabledColor: Colors.white,
      animationDuration: const Duration(milliseconds: 1000),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: fontSize ?? 14,
              color: textColor ?? Colors.white,
            ),
          ),
          if(loading) Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: textColor,
                strokeWidth: 3,
              ),
            ),
          )
        ],
      ),
    );
  }
}