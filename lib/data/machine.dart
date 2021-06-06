import 'package:flutter/material.dart';

class Machine {
  String machineName, workspaceName;
  bool certificateGranted;

  Machine(
      {required this.machineName,
      required this.workspaceName,
      required this.certificateGranted});
}
