import 'package:flutter/material.dart';

class Certificates extends StatefulWidget {
  @override
  _CertificatesState createState() => _CertificatesState();
}

class _CertificatesState extends State<Certificates> {
  int _currentIndex = 2;
  String route = '/certificates';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade500,
        title: Text('Certificates'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: ElevatedButton(
              onPressed: null,
              child: null,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Colors.teal.shade500,
        selectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.qr_code_scanner), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(
              icon: Icon(Icons.edit), label: 'Certificates'),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            if (index == 0) {
              route = '/home';
            } else if (index == 1) {
              route = '/history';
            } else {
              route = '/certificates';
            }
            Navigator.pushNamed(context, route);
          });
        },
      ),
    );
  }
}
