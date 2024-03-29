import 'package:certificate_app/data/certificate.dart';
import 'package:certificate_app/data/workspace.dart';
import 'package:certificate_app/helper/api_requests.dart';
import 'package:flutter/material.dart';
import 'package:certificate_app/data/machine.dart';
import 'package:certificate_app/helper/drawer.dart';
import 'package:certificate_app/helper/bottom_navbar.dart';
import 'dart:async';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Machines extends StatefulWidget {
  @override
  _MachinesState createState() => _MachinesState();
}

class _MachinesState extends State<Machines> {
  int _currentIndex = 2;
  bool checkCerts = false;

  List<Machine> _machines = [];
  List<Certificate> _certificates = [];
  List<Machine> _certMachines = [];
  Workspace ws = Workspace('', '', '', '');

  Future fetchMachines() async {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    int id = args['workplaceId'];
    ws = await ApiRequests().getWorkplace(id);
    await ApiRequests().getMachinesList(id).then((value) {
      setState(() {
        _machines.addAll(value);
      });
    });
    await ApiRequests()
        .getCertificates(await ApiRequests().getStudentNumber())
        .then((value) {
      setState(() {
        _certificates.addAll(value);
      });
    });
    for (int i = 0; i < _certificates.length; i++) {
      for (int j = 0; j < _machines.length; j++) {
        if (_certificates.elementAt(i).machineId ==
            _machines.elementAt(j).certificateId) {
          _machines.elementAt(j).certificateGranted = true;
          _certMachines.add(_machines.elementAt(j));
        }
      }
    }
  }

  /*List<Machine> machinesList = [
    Machine(
      machineId: '1',
        machineName: 'Drucker',
        workspaceName: 'IT Workspace',
        certificateGranted: false),
    Machine(
        machineId: '2',
        machineName: 'C102',
        workspaceName: 'Chemistry Workspace',
        certificateGranted: false),
    Machine(
        machineId: '3',
        machineName: 'C103',
        workspaceName: 'Biology Workspace',
        certificateGranted: false),
  ];

  List<Machine> machinesListCertGranted = [
    Machine(
        machineId: '1',
        machineName: 'Drucker',
        workspaceName: 'IT Workspace',
        certificateGranted: false),
    Machine(
        machineId: '2',
        machineName: 'C102',
        workspaceName: 'Chemistry Workspace',
        certificateGranted: false),
  ];*/

  Future<Widget> getImage(Machine machine) async {
    final Completer<Widget> completer = Completer();
    final url = machine.picture;
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

  Widget machineCard(Machine machine, Workspace ws) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          ListTile(
            title: Text(machine.machineName),
            subtitle: Text(ws.workspaceName + ' ' + ws.bldInformation),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: FutureBuilder<Widget>(
              future: getImage(machine),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data!;
                } else {
                  return Text(AppLocalizations.of(context)!.loading);
                }
              },
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 0.0),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              const SizedBox(width: 8),
              TextButton(
                child:
                    Text(AppLocalizations.of(context)!.showSafetyInstructions),
                onPressed: () {
                  Navigator.pushNamed(context, '/safety_instructions',
                      arguments: {
                        'workplaceId': int.parse(ws.id),
                        'machineId': int.parse(machine.machineId)
                      });
                },
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      fetchMachines();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade500,
        title: Text(AppLocalizations.of(context)!.machines),
      ),
      drawer: drawerWidget(),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
          child: Row(
            children: [
              Text(
                AppLocalizations.of(context)!.showGrantedOnly,
                style: TextStyle(),
              ),
              Checkbox(
                value: checkCerts,
                onChanged: (checked) {
                  setState(() {
                    checkCerts = checked!;
                  });
                },
                activeColor: Colors.teal.shade500,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: checkCerts
                ? _certMachines
                    .map((machine) => machineCard(machine, ws))
                    .toList()
                : _machines.map((machine) => machineCard(machine, ws)).toList(),
          ),
        ),
      ]),
      bottomNavigationBar: bottomNavBar(currentIndex: _currentIndex),
    );
  }
}
