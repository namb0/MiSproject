import 'package:flutter/material.dart';

class drawerWidget extends StatelessWidget {
  const drawerWidget({
    Key? key,
  }) : super(key: key);

  final String accName = 'John', accNumber = 'r812386';

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('$accName'),
            accountEmail: Text('$accNumber'),
            decoration: BoxDecoration(
              color: Colors.teal.shade500,
            ),
            /*child: Text(
              'LUCA \nQR Certification App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),*/
          ),
          Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Sign Out'),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
