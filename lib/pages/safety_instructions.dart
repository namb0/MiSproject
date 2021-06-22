import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:certificate_app/data/machine.dart';
import 'package:certificate_app/helper/drawer.dart';
import 'package:certificate_app/helper/bottom_navbar.dart';
import 'dart:async';

class SafetyInstructions extends StatefulWidget {
  @override
  _SafetyInstructionsState createState() => _SafetyInstructionsState();
}

class _SafetyInstructionsState extends State<SafetyInstructions> {
  int _currentIndex = 2;
  Machine machine = Machine.full('', '', '', '', '', false);

  Future fetchMachine() async {
    final args = ModalRoute.of(context)!.settings.arguments as Machine;
    machine = Machine.full(
        args.machineId,
        args.machineName,
        args.workspaceName,
        args.picture,
        args.safetyInstructions,
        args.certificateGranted);
  }

  Future<Widget> getImage() async {
    final Completer<Widget> completer = Completer();
    final url = machine.safetyInstructions;
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

  Widget informationCard(Machine machine) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        ListTile(
          title: Text(machine.machineName),
          subtitle: Text(machine.workspaceName),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 16.0),
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
        Container(
          padding: EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 12.0),
          alignment: Alignment.centerLeft,
          child:
              Text('Safety instructions: ', style: TextStyle(fontSize: 20.0)),
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
                  return Text('LOADING...');
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
    fetchMachine();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade500,
        title: Text('Machine Information'),
      ),
      drawer: drawerWidget(),
      body: Container(
        child: informationCard(machine),
      ),
      bottomNavigationBar: bottomNavBar(currentIndex: _currentIndex),
    );
  }
}
