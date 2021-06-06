import 'package:flutter/material.dart';
import 'package:certificate_app/pages/home.dart';
import 'package:certificate_app/pages/history.dart';
import 'package:certificate_app/pages/workspaces.dart';
import 'package:certificate_app/pages/machines.dart';
import 'package:certificate_app/pages/safety_instructions.dart';
import 'package:certificate_app/pages/certificates.dart';
import 'package:certificate_app/pages/login.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/login',
    routes: {
      '/login': (context) => Login(),
      '/home': (context) => Home(),
      '/history': (context) => History(),
      '/workspaces': (context) => Workspaces(),
      '/machines': (context) => Machines(),
      '/safety_instructions': (context) => SafetyInstructions(),
      '/certificates': (context) => Certificates(),
    },
  ));
}
