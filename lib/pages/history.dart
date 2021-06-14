import 'package:flutter/material.dart';
import 'package:certificate_app/helper/drawer.dart';
import 'package:certificate_app/helper/bottom_navbar.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade500,
        title: Text('History'),
      ),
      drawer: drawerWidget(),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'List of recently scanned QR codes',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomNavBar(currentIndex: _currentIndex),
    );
  }
}
