import 'package:certificate_app/data/certificate.dart';
import 'package:certificate_app/data/workspace.dart';
import 'package:certificate_app/helper/api_requests.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:certificate_app/data/machine.dart';
import 'package:certificate_app/helper/drawer.dart';
import 'package:certificate_app/helper/bottom_navbar.dart';
import 'dart:async';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SafetyInstructions extends StatefulWidget {
  @override
  _SafetyInstructionsState createState() => _SafetyInstructionsState();
}

class _SafetyInstructionsState extends State<SafetyInstructions> {
  int _currentIndex = 2;
  List<Certificate> _certificates = [];
  Workspace ws = Workspace('', '', '', '');
  Machine machine = Machine.full('', '', '', '', '', '', false);

  Future fetchMachine() async {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    int workplaceId = args['workplaceId'];
    int machineId = args['machineId'];
    ws = await ApiRequests().getWorkplace(workplaceId);
    machine = await ApiRequests().getMachine(workplaceId, machineId);
    await ApiRequests()
        .getCertificates(await ApiRequests().getStudentNumber())
        .then((value) {
      setState(() {
        _certificates.addAll(value);
      });
    });
    for (int i = 0; i < _certificates.length; i++) {
      if (_certificates.elementAt(i).machineId == machine.certificateId) {
        machine.certificateGranted = true;
      }
    }
  }

  Future<Widget> getImage() async {
    final Completer<Widget> completer = Completer();
    final url = machine.safetyInstructions;
    final image = NetworkImage(url);
    // final config = await image.obtainKey();
    final load = image.resolve(const ImageConfiguration());

    final listener = new ImageStreamListener((ImageInfo info, isSync) async {
      //print(info.image.width);
      //print(info.image.height);

      if (info.image.width == 80 && info.image.height == 160) {
        completer.complete(Container(child: Text('AZAZA')));
      } else {
        completer.complete(Container(child: Image(image: image)));
      }
    });

    load.addListener(listener);
    return completer.future;
  }

  Widget informationCard(Machine machine) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        ListTile(
          title: Text(machine.machineName),
          subtitle: Text(ws.workspaceName),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 16.0),
          alignment: Alignment.centerLeft,
          child: RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
              children: [
                TextSpan(
                  text: AppLocalizations.of(context)!.certificateGranted,
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                ),
                WidgetSpan(
                  child: machine.certificateGranted
                      ? Icon(Icons.check, size: 20, color: Colors.green)
                      : Icon(Icons.close, size: 20, color: Colors.red),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 12.0),
          alignment: Alignment.centerLeft,
          child: Text(AppLocalizations.of(context)!.safetyInstructions,
              style: TextStyle(fontSize: 20.0)),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
          alignment: Alignment.center,
          child: InteractiveViewer(
            clipBehavior: Clip.none,
            child: FutureBuilder<Widget>(
              future: getImage(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data!;
                } else {
                  return Text(AppLocalizations.of(context)!.loading);
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      fetchMachine();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade500,
        title: Text(AppLocalizations.of(context)!.machineInformation),
      ),
      drawer: drawerWidget(),
      body: Container(
        child: informationCard(machine),
      ),
      bottomNavigationBar: bottomNavBar(currentIndex: _currentIndex),
    );
  }
}
