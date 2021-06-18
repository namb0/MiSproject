import 'package:flutter/material.dart';
import 'package:certificate_app/helper/drawer.dart';
import 'package:certificate_app/helper/bottom_navbar.dart';
import 'package:certificate_app/data/history.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  int _currentIndex = 1;

  List<Logdata> loglist = [
    Logdata(
        machinename: 'Drucker',
        workspace: 'IT Workspace',
        datetime: '12:05:2021 08:15:02'),
    Logdata(
        machinename: 'C102',
        workspace: 'Biology Workspace',
        datetime: '16:05:2021 12:00:32'),
    Logdata(
        machinename: 'C103',
        workspace: 'Chemistry Workspace',
        datetime: '16:05:2021 14:45:23'),
  ];

  Widget historyCard(Logdata log) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Text(log.datetime),
            title: Text(log.workspace),
            subtitle: Text(log.machinename),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade500,
        title: Text('History'),
      ),
      drawer: drawerWidget(),
      body: ListView(
        children: loglist
            .map((workspace) =>historyCard(workspace))
            .toList(),
      ),
      bottomNavigationBar: bottomNavBar(currentIndex: _currentIndex),
    );
  }
}
