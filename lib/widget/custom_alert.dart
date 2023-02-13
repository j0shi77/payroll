import 'package:flutter/material.dart';

class CustomAlert extends StatelessWidget {
  const CustomAlert({
    Key? key,
    required this.type,
    required this.title,
    // required this.onPressed,
  }) : super(key: key);

  final String type;
  final String title;
  // final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    if(type == 'success'){
      return SizedBox(
        width: double.infinity,
        child: Material(
          color: const Color(0xFFE8F5E9),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  const Icon(Icons.check, color: Color(0XFF1B5E20)),
                  const SizedBox(width: 8,),
                  Text(
                    title,
                    style: const TextStyle(
                        color: Color(0XFF1B5E20),
                        fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
          )
        )
      );
    }else if(type == 'pending'){
      return SizedBox(
          width: double.infinity,
          child: Material(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    const Icon(Icons.warning, color: Color(0XFF1B5E20)),
                    const SizedBox(width: 8,),
                    Text(
                      title,
                      style: const TextStyle(
                          color: Color(0XFF1B5E20),
                          fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              )
          )
      );
    }else{
      return SizedBox(
          width: double.infinity,
          child: Material(
              color: const Color(0xffffebee),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: const Color(0xFFB71c1c), strokeAlign: StrokeAlign.outside),
                    borderRadius: BorderRadius.circular(8) ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: [
                      const Icon(Icons.dangerous, size: 15, color: Color(0xFFB71c1c)),
                      const SizedBox(width: 8,),
                      Text(
                        title,
                        style: const TextStyle(
                            color: Color(0xFFB71c1c),
                            fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                ),
              )
          )
      );
    }
  }
}
