import 'package:flutter/material.dart';
import 'package:certificate_app/data/workspace.dart';
import 'package:certificate_app/helper/drawer.dart';
import 'package:certificate_app/helper/bottom_navbar.dart';
import 'package:certificate_app/helper/api_requests.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Workspaces extends StatefulWidget {
  @override
  _WorkspacesState createState() => _WorkspacesState();
}

class _WorkspacesState extends State<Workspaces> {
  int _currentIndex = 2;

  List<Workspace> _workspaces = [];

  Future fetchWorkspaces() async {
    ApiRequests().getWorkplacesList().then((value) {
      setState(() {
        _workspaces.addAll(value);
      });
    });
  }

/*
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
  ];*/

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
                child: Text(AppLocalizations.of(context)!.showMachines),
                onPressed: () {
                  Navigator.pushNamed(context, '/machines',
                      arguments: {'workplaceId': int.parse(workspace.id)});
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
    fetchWorkspaces();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade500,
        title: Text(AppLocalizations.of(context)!.workspaces),
      ),
      drawer: drawerWidget(),
      body: ListView(
        children:
            _workspaces.map((workspace) => workspaceCard(workspace)).toList(),
      ),
      bottomNavigationBar: bottomNavBar(currentIndex: _currentIndex),
    );
  }
}
