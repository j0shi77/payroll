import 'package:flutter/material.dart';
import 'package:payroll_app/models/EmployeeList.dart';
import 'package:payroll_app/services/employee_service.dart';
import 'package:payroll_app/widget/employee/employee_item.dart';


class EmployeePage extends StatefulWidget {
  const EmployeePage({Key? key}) : super(key: key);

  @override
  State<EmployeePage> createState() => EmployeePageState();
}

class EmployeePageState extends State<EmployeePage> {

  final employeeService = EmployeeService();
  String q = '';

  List<Data> employeeList = [];

  Future getEmployee() async {
    var resp = await employeeService.fetchEmployeeList(q);
    if(resp.status == 200){
      setState(() {
        employeeList = resp.data!;
      });
    }else{

    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getEmployee();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 40),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Karyawan",
                      style: TextStyle(
                          color: Color(0XFF000000),
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${employeeList.length} Orang",
                      style: const TextStyle(
                          color: Color(0XFFA2A6A6),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: RefreshIndicator(
                      onRefresh: () async {
                        getEmployee();
                      },
                      child: ListView.builder(
                          itemCount: employeeList.length,
                          itemBuilder: (context, index) {
                            return EmployeeItem(index, employeeList);
                          })
                    )
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
