import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class IssueApprovalPage extends StatefulWidget {
  const IssueApprovalPage({Key? key}) : super(key: key);

  @override
  State<IssueApprovalPage> createState() => _IssueApprovalPageState();
}

class _IssueApprovalPageState extends State<IssueApprovalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Issue Approbal"),
    );
  }
}
