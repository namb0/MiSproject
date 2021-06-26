import 'dart:html';

import 'package:flutter/material.dart';
import 'package:certificate_app/helper/drawer.dart';
import 'package:certificate_app/helper/bottom_navbar.dart';
import 'package:certificate_app/data/history.dart';
import 'package:certificate_app/helper/api_requests.dart';
import 'package:shared_preferences/shared_preferences.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  int _currentIndex = 1;

  List<History> _logdata =[];

  Future fetchHistory() async {
    ApiRequests().getHistory().then((value) { //id vom user eintragen? woher amk
      setState(() {
        _logdata.addAll(value);
      });
    });
  }

/*
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
*/
  Widget historyCard(Historydata log) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Text(log.datetime),
            title: Text(log.workspace),
           /* subtitle: Text(log.machinename),*/
          ),
        ],
      ),
    );
  }

  void initState() {
    fetchHistory();
    super.initState();
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
        children: _logdata
            .map((log) =>historyCard(log)) //warum klapt nicht :'(
            .toList(),
      ),
      bottomNavigationBar: bottomNavBar(currentIndex: _currentIndex),
    );
  }
}
