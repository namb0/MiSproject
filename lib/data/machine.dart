class Machine {
  String machineId = 'N/A',
      machineName = 'N/A',
      workspaceName = 'N/A',
      picture = 'N/A',
      safetyInstructions = 'N/A',
      certificateId = 'N/A';
  bool certificateGranted = false;

  Machine(
      {required this.machineName,
      required this.workspaceName,
      required this.machineId,
      required this.certificateGranted});

  Machine.full(this.machineId, this.machineName, this.workspaceName,
      this.picture, this.safetyInstructions, this.certificateId, this.certificateGranted);

  Machine.fromJson(Map<String, dynamic> json) {
    machineId = json['machine_id']['stringValue'];
    machineName = json['name']['stringValue'];
    picture = json['picture']['stringValue'];
    safetyInstructions = json['safety_instructions']['stringValue'];
    certificateId = json['certificate_id']['stringValue'];
  }
}
