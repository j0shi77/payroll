import 'package:flutter/material.dart';
import 'package:payroll_app/services/account_service.dart';
import 'package:payroll_app/view/account/edit_data.dart';
import 'package:payroll_app/widget/button_custom.dart';
import 'package:payroll_app/widget/custom_appbar.dart';

import '../../models/AccountResponse.dart';

class InfoPayrollPage extends StatefulWidget {
  const InfoPayrollPage({Key? key}) : super(key: key);

  @override
  State<InfoPayrollPage> createState() => _InfoPayrollPageState();
}

class _InfoPayrollPageState extends State<InfoPayrollPage> {

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
              title: "Info Payroll",
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
              height: (MediaQuery.of(context).size.height) * 0.9,
              child: Card(
                shadowColor: Color.fromARGB(126, 255, 255, 255),
                elevation: 16,
                child: Column(
                  children:  [
                    ListTile(
                      subtitle: Text(
                        "${account.bpjsKerjaNumber}",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      title: Text(
                        "BPJS Ketenagakerjaan",
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
                        "${account.bpjsKesehatanNumber}",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      title: Text(
                        "BPJS Kesehatan",
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
                        "${account.npwp}",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      title: Text(
                        "NPWP",
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
                        "${account.bankName}",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      title: Text(
                        "Nama Bank",
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
                        "${account.accountNumber}",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      title: Text(
                        "No Rekening",
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
                        "${account.accountHolderName}",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      title: Text(
                        "Nama Pemilik",
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
          ),
          Align(
            alignment: Alignment(1.0, 0.8),
            child: ButtonProfile(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditData()),
                );
              },
              title: "Ajukan Perubahan Data",
              colour: Color(0xFFCD0101),
            ),
          )
        ],
      ),
    );
  }
}
