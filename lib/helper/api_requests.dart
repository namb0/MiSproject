import 'dart:convert';
import 'package:certificate_app/data/certificate.dart';
import 'package:certificate_app/data/logs.dart';
import 'package:certificate_app/data/machine.dart';
import 'package:certificate_app/data/workspace.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiRequests {
  Future getWorkplacesList() async {
    var url = Uri.parse(
        'https://firestore.googleapis.com/v1/projects/certificate-app-8bce0/databases/(default)/documents/Workplaces');
    var response = await get(url);

    List<Workspace> workspaceList = [];

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> workplaces = map['documents'];

      /*for (var workplace in workplaces) {
        print(workplace['fields']['room']);
        String room = workplace['fields']['room']['stringValue'];
        String name = workplace['fields']['name']['stringValue'];
        String responsible = workplace['fields']['responsible']['stringValue'];
        Workspace ws = Workspace(bldInformation: room, workspaceName: name, workspaceResponsible: responsible);
        workspaceList.add(ws);
      }*/

      for (var workplace in workplaces) {
        //print(workplace['fields']['id']['stringValue']);
        workspaceList.add(Workspace.fromJson(workplace['fields']));
      }
    }
    return workspaceList;
  }

  Future getMachinesList(int id) async {
    var url = Uri.parse(
        'https://firestore.googleapis.com/v1/projects/certificate-app-8bce0/databases/(default)/documents/Workplaces/$id/Machines');
    var response = await get(url);

    List<Machine> machineList = [];

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> machines = map['documents'];

      for (var machine in machines) {
        machineList.add(Machine.fromJson(machine['fields']));
      }
    }
    return machineList;
  }

  Future<Workspace> getWorkplace(id) async {
    var url = Uri.parse(
        'https://firestore.googleapis.com/v1/projects/certificate-app-8bce0/databases/(default)/documents/Workplaces/$id');
    var response = await get(url);

    if (response.statusCode == 200) {
      var workplace = json.decode(response.body);
      return Workspace.fromJson(workplace['fields']);
    }

    return Workspace(
      'N/A',
      'N/A',
      'N/A',
      'N/A',
    );
  }

  Future<Machine> getMachine(workplaceId, machineId) async {
    var url = Uri.parse(
        'https://firestore.googleapis.com/v1/projects/certificate-app-8bce0/databases/(default)/documents/Workplaces/$workplaceId/Machines/$machineId');
    var response = await get(url);
    print(url.toString());

    if (response.statusCode == 200) {
      var workplace = json.decode(response.body);
      return Machine.fromJson(workplace['fields']);
    }

    return Machine(
        machineId: 'N/A',
        machineName: 'N/A',
        workspaceName: 'N/A',
        certificateGranted: false);
  }

  Future getCertificates(id) async {
    var url = Uri.parse(
        'https://firestore.googleapis.com/v1/projects/certificate-app-8bce0/databases/(default)/documents/User/$id/Certificates');
    var response = await get(url);

    List<Certificate> certificateList = [];

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> certificates = map['documents'];

      for (var certificate in certificates) {
        //print(certificate['fields']['machine_id']['stringValue']);
        certificateList.add(Certificate.fromJson(certificate['fields']));
      }
    }
    return certificateList;
  }

  Future getLogs() async {
    var url = Uri.parse(
        'https://firestore.googleapis.com/v1/projects/certificate-app-8bce0/databases/(default)/documents/Logs');
    var response = await get(url);

    List<Logs> logList = [];

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> logs = map['documents'];

      for (var log in logs) {
        logList.add(Logs.fromJson(log['fields']));
      }
    }
    return logList;
  }

  Future<String> getStudentNumber() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    var sharedPrefstudentNumber = sharedPreferences.getString('student number');
    return sharedPrefstudentNumber!;
  }
}
