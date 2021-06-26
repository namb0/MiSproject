import 'dart:convert';
import 'package:certificate_app/data/certificate.dart';
import 'package:certificate_app/data/machine.dart';
import 'package:certificate_app/data/workspace.dart';
import 'package:certificate_app/data/history.dart';
import 'package:http/http.dart';

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

  Future<Workspace> getMachine(workplaceId, machineId) async {
    var url = Uri.parse(
        'https://firestore.googleapis.com/v1/projects/certificate-app-8bce0/databases/(default)/documents/Workplaces/$workplaceId/Machines/$machineId');
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

  Future getCertificates(id) async {
    var url = Uri.parse(
        'https://firestore.googleapis.com/v1/projects/certificate-app-8bce0/databases/(default)/documents/User/$id/Certificates');
    var response = await get(url);

    List<Certificate> certificateList = [];

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> certificates = map['documents'];

      for (var certificate in certificates) {
        print(certificate['fields']['machine_id']['stringValue']);
        certificateList.add(Certificate.fromJson(certificate['fields']));
      }
    }
    return certificateList;
  }

  Future getHistory(id) async { // link noch anpassen, denke ansonsten fresh oder
    var url = Uri.parse(
        'https://firestore.googleapis.com/v1/projects/certificate-app-8bce0/databases/(default)/documents/User/$id/Certificates');
    var response = await get(url);

    List<Historydata> historyList = [];

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> logdata = map['documents'];

      for (var log in logdata) {
        /*print(log['fields']['machine_id']['stringValue']);*/
        historyList.add(Historydata.fromJson(log['fields']));
      }
    }
    return historyList;
  }

}
