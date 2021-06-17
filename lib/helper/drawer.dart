import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class drawerWidget extends StatelessWidget {
  drawerWidget({
    Key? key,
  }) : super(key: key);

  String name = '', studentnumber = '';

  Future<String> initUserData() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    var sharedPrefname = sharedPreferences.getString('name');
    var sharedPrefstudentNumber = sharedPreferences.getString('student number');
    name = sharedPrefname!;
    studentnumber = sharedPrefstudentNumber!;
    return name;
  }

  @override
  Widget build(BuildContext context) {
    initUserData();

    return Drawer(
      child: Column(
        children: <Widget>[
          FutureBuilder(
              future: initUserData(),
              builder: (context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  return UserAccountsDrawerHeader(
                    accountName: Text('$name'),
                    accountEmail: Text('$studentnumber'),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade500,
                    ),
                  );
                } else {
                  return UserAccountsDrawerHeader(
                    accountName: Text('Loading...'),
                    accountEmail: Text(''),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade500,
                    ),
                  );
                }
              }),
          Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Sign Out'),
                onTap: () async {
                  final sharedPreferences =
                      await SharedPreferences.getInstance();
                  sharedPreferences.clear();
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
