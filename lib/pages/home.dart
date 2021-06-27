import 'package:flutter/material.dart';
import 'package:certificate_app/helper/drawer.dart';
import 'package:certificate_app/helper/bottom_navbar.dart';
import 'package:certificate_app/helper/qr_scanner.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade500,
        title: Text(AppLocalizations.of(context)!.home),
      ),
      drawer: drawerWidget(),
      body: QRViewExample(),
      bottomNavigationBar: bottomNavBar(currentIndex: _currentIndex),
    );
  }
}
