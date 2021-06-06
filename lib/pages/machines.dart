import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:certificate_app/data/machine.dart';
import 'package:certificate_app/helper/drawer.dart';
import 'dart:async';

class Machines extends StatefulWidget {
  @override
  _MachinesState createState() => _MachinesState();
}

class _MachinesState extends State<Machines> {
  int _currentIndex = 2;

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
                    child: machine.certificateGranted ? Icon(Icons.check, size: 20, color: Colors.green): Icon(Icons.close, size: 20, color: Colors.red),
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
                  Navigator.pushReplacementNamed(context, '/safety_instructions');
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
      body: ListView(
        children: machinesList.map((machine) => machineCard(machine)).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        backgroundColor: Colors.teal.shade500,
        selectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.qr_code_scanner), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(
              icon: Icon(Icons.home_work), label: 'Workspaces'),
          BottomNavigationBarItem(
              icon: Icon(Icons.edit), label: 'Certificates'),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/history');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/workspaces');
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/certificates');
              break;
          }
        },
      ),
    );
  }
}
