import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payroll_app/services/account_service.dart';
import 'package:payroll_app/widget/custom_appbar.dart';

import '../../models/AccountResponse.dart';


class InfoContractPage extends StatefulWidget {

  const InfoContractPage({Key? key}) : super(key: key);


  @override
  State<InfoContractPage> createState() => _InfoContractPageState();
}

class _InfoContractPageState extends State<InfoContractPage> {

  final accountService = AccountService();

  Data account = Data();

  getAccount () async {
    var resp = await AccountService().fetchAccount()!;
    if(resp.status == 200){
      setState(() {
        account = resp.data!;
      });
    }else{
      //
    }
  }

  @override
  void initState() {
    super.initState();

    getAccount();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
        children: <Widget>[
          Container(
            height: 200,
            child: ProfileAppbar(
              title: "Info Kontrak",
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 80,
              right: 10,
              left: 10,
              bottom: 120,
            ),
            child: Card(
              shadowColor: Color.fromARGB(126, 255, 255, 255),
              elevation: 16,
              child: Column(
                children:  [
                  ListTile(
                    subtitle: Text(
                      "${account.employeeId}",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    title: Text(
                      "ID Karyawan",
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        letterSpacing: 0.2,
                        fontSize: 14,
                        color: Color.fromARGB(255, 124, 124, 124),
                      ),
                    ),
                  ),
                  ListTile(
                    subtitle: Text(
                      "${account.jobPositionName}",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    title: Text(
                      "Peran",
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        letterSpacing: 0.2,
                        fontSize: 14,
                        color: Color.fromARGB(255, 124, 124, 124),
                      ),
                    ),
                  ),
                  ListTile(
                    subtitle: Text(
                      "${account.organizationName}",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    title: Text(
                      "Nama Perusahaan",
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        letterSpacing: 0.2,
                        fontSize: 14,
                        color: Color.fromARGB(255, 124, 124, 124),
                      ),
                    ),
                  ),
                  ListTile(
                    subtitle: Text(
                      "${account.jobLevelName}",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    title: Text(
                      "Level Pekerjaan",
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        letterSpacing: 0.2,
                        fontSize: 14,
                        color: Color.fromARGB(255, 124, 124, 124),
                      ),
                    ),
                  ),
                  ListTile(
                    subtitle: Text(
                      "${account.employeeStatus}",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    title: Text(
                      "Status Pekerjaan",
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        letterSpacing: 0.2,
                        fontSize: 14,
                        color: Color.fromARGB(255, 124, 124, 124),
                      ),
                    ),
                  ),
                  ListTile(
                    subtitle: Text(
                      "${account.yearsOfService}",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    title: Text(
                      "Masa Kerja",
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        letterSpacing: 0.2,
                        fontSize: 14,
                        color: Color.fromARGB(255, 124, 124, 124),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      );
  }
}