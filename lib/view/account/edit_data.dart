import 'package:flutter/material.dart';
import 'package:payroll_app/widget/button_custom.dart';
import 'package:payroll_app/widget/custom_appbar.dart';
import 'package:payroll_app/widget/form_custom.dart';

class EditData extends StatefulWidget {
  const EditData({Key? key}) : super(key: key);

  @override
  State<EditData> createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child:Stack(
        children: <Widget>[
          const SizedBox(
            height: 200,
            child: ProfileAppbar(
              title: "Perubahan Data",
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 80,
              right: 10,
              left: 10,
              bottom: 120,
            ),
            child: SizedBox(
              height: 250,
              child: Card(
                shadowColor: const Color.fromARGB(126, 255, 255, 255),
                elevation: 16,
                child: Column(
                  children: [
                    OptionCustom(textHint: "Jenis Data", items: const [],onChanged: (val){}),
                    const FormCustom(label: "Diubah Menjadi"),
                    const FormCustom(label: "Keterangan"),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: Column(
              children: [
                ButtonProfile(
                  onPressed: () {},
                  title: "Ajukan Perubahan",
                  colour: Color.fromARGB(255, 1, 55, 205),
                ),
                const SizedBox(height: 10,),
                ButtonProfile(
                  onPressed: () {},
                  title: "Batal",
                  colour: Color.fromARGB(255, 138, 138, 138),
                ),
              ],
            ),
          )
        ],
      ),
      ) 
    );
  }
}
