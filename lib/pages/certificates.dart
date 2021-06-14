import 'package:flutter/material.dart';
import 'package:certificate_app/helper/drawer.dart';
import 'package:certificate_app/helper/bottom_navbar.dart';

class Certificates extends StatefulWidget {
  @override
  _CertificatesState createState() => _CertificatesState();
}

class _CertificatesState extends State<Certificates> {
  int _currentIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade500,
        title: Text('Certificates'),
      ),
      drawer: drawerWidget(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text('Workspaces'),
                style: ElevatedButton.styleFrom(
                    primary: Colors.grey.shade200,
                    onPrimary: Colors.black,
                    minimumSize: Size(200, 100)),
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: Text('Machines'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.grey.shade200,
                      onPrimary: Colors.black,
                      minimumSize: Size(200, 100))),
            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomNavBar(currentIndex: _currentIndex),
    );
  }
}
