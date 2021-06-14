import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:certificate_app/data/workspace.dart';
import 'package:certificate_app/helper/drawer.dart';
import 'package:certificate_app/helper/bottom_navbar.dart';

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
                  Navigator.pushNamed(context, '/machines');
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
      bottomNavigationBar: bottomNavBar(currentIndex: _currentIndex),
    );
  }
}
