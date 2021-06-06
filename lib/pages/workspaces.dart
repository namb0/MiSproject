import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:certificate_app/data/workspace.dart';
import 'package:certificate_app/helper/drawer.dart';

class Workspaces extends StatefulWidget {
  @override
  _WorkspacesState createState() => _WorkspacesState();
}

class _WorkspacesState extends State<Workspaces> {
  int _currentIndex = 2;

  List<Workspace> workspacesList = [
    Workspace(
        bldInformation: 'C101',
        workspaceName: 'IT Workspace',
        workspaceResponsible: 'Max Musterresponsible'),
    Workspace(
        bldInformation: 'C102',
        workspaceName: 'Chemistry Workspace',
        workspaceResponsible: 'Max Musterresponsible'),
    Workspace(
        bldInformation: 'C103',
        workspaceName: 'Biology Workspace',
        workspaceResponsible: 'Max Musterresponsible'),
  ];

  Widget workspaceCard(Workspace workspace) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Text(workspace.bldInformation),
            title: Text(workspace.workspaceName),
            subtitle: Text(workspace.workspaceResponsible),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              const SizedBox(width: 8),
              TextButton(
                child: const Text('SHOW MACHINES'),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/machines');
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
        title: Text('Workspaces'),
      ),
      drawer: drawerWidget(),
      body: ListView(
        children: workspacesList
            .map((workspace) => workspaceCard(workspace))
            .toList(),
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
