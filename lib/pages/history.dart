import 'package:certificate_app/data/logs.dart';
import 'package:certificate_app/data/workspace.dart';
import 'package:certificate_app/helper/api_requests.dart';
import 'package:flutter/material.dart';
import 'package:certificate_app/helper/drawer.dart';
import 'package:certificate_app/helper/bottom_navbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  int _currentIndex = 1;

  List<Logs> _logs = [];
  List<Logs> _myLogs = [];
  Workspace ws = Workspace('', '', '', '');

  Future fetchLogHistory() async {
    await ApiRequests().getLogs().then((value) {
      _logs.addAll(value);
    });

    for (int i = 0; i < _logs.length; i++) {
      ws = await ApiRequests().getWorkplace(_logs.elementAt(i).workplaceId);
      _logs.elementAt(i).workplaceName = ws.workspaceName;
      if (_logs.elementAt(i).studentNumber ==
          await ApiRequests().getStudentNumber()) {
        _myLogs.add(_logs.elementAt(i));
      }
      print('before sort' + _myLogs.elementAt(i).datetime);
    }
    setState(() {
      _myLogs.sort();
    });
    for (int i = 0; i < _myLogs.length; i++) {
      print('after sort' + _myLogs.elementAt(i).datetime);
    }
  }

  Widget historyCard(Logs log) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Text(
                DateFormat.yMd().add_jm().format(DateTime.parse(log.datetime))),
            title: Text(log.workplaceName),
          ),
        ],
      ),
    );
  }

  void initState() {
    Future.delayed(Duration.zero, () {
      fetchLogHistory();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade500,
        title: Text(AppLocalizations.of(context)!.history),
      ),
      drawer: drawerWidget(),
      body: _myLogs.length > 0
          ? ListView(
              children: _myLogs.map((log) => historyCard(log)).toList(),
              reverse: true,
              shrinkWrap: true,
            )
          : Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.historyList,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: bottomNavBar(currentIndex: _currentIndex),
    );
  }
}
