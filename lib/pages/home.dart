import 'package:flutter/material.dart';
import 'package:certificate_app/helper/drawer.dart';
import 'package:certificate_app/helper/bottom_navbar.dart';
import 'package:certificate_app/helper/qr_scanner.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  
  QRViewExample scanner = new QRViewExample();
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade500,
        title: Text('Home'),
      ),
      drawer: drawerWidget(),
      body: QRViewExample(),
      
      bottomNavigationBar: bottomNavBar(currentIndex: _currentIndex),
    );
  }
}
