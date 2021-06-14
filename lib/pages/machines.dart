import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:certificate_app/data/machine.dart';
import 'package:certificate_app/helper/drawer.dart';
import 'package:certificate_app/helper/bottom_navbar.dart';
import 'dart:async';

class Machines extends StatefulWidget {
  @override
  _MachinesState createState() => _MachinesState();
}

class _MachinesState extends State<Machines> {
  int _currentIndex = 2;
  bool checkCerts = false;

  List<Machine> machinesList = [
    Machine(
        machineName: 'Drucker',
        workspaceName: 'IT Workspace',
        certificateGranted: true),
    Machine(
        machineName: 'C102',
        workspaceName: 'Chemistry Workspace',
        certificateGranted: true),
    Machine(
        machineName: 'C103',
        workspaceName: 'Biology Workspace',
        certificateGranted: false),
  ];

  List<Machine> machinesListCertGranted = [
    Machine(
        machineName: 'Drucker',
        workspaceName: 'IT Workspace',
        certificateGranted: true),
    Machine(
        machineName: 'C102',
        workspaceName: 'Chemistry Workspace',
        certificateGranted: true),
  ];

  Future<Widget> getImage() async {
    final Completer<Widget> completer = Completer();
    final url = 'https://picsum.photos/900/600';
    final image = NetworkImage(url);
    // final config = await image.obtainKey();
    final load = image.resolve(const ImageConfiguration());

    final listener = new ImageStreamListener((ImageInfo info, isSync) async {
      print(info.image.width);
      print(info.image.height);

      if (info.image.width == 80 && info.image.height == 160) {
        completer.complete(Container(child: Text('AZAZA')));
      } else {
        completer.complete(Container(child: Image(image: image)));
      }
    });

    load.addListener(listener);
    return completer.future;
  }

  Widget machineCard(Machine machine) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          ListTile(
            title: Text(machine.machineName),
            subtitle: Text(machine.workspaceName),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: FutureBuilder<Widget>(
              future: getImage(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data!;
                } else {
                  return Text('LOADING...');
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
                    text: "Certificate granted: ",
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
                child: const Text('SAFETY INSTRUCTIONS'),
                onPressed: () {
                  Navigator.pushNamed(
                      context, '/safety_instructions');
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade500,
        title: Text('Machines'),
      ),
      drawer: drawerWidget(),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
          child: Row(
            children: [
              Text(
                'Show only granted certificates: ',
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
                ? machinesListCertGranted
                    .map((machine) => machineCard(machine))
                    .toList()
                : machinesList.map((machine) => machineCard(machine)).toList(),
          ),
        ),
      ]),
      bottomNavigationBar: bottomNavBar(currentIndex: _currentIndex),
    );
  }
}