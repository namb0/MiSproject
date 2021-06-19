class Certificate {
  String machineId = 'N/A';

  Certificate({required this.machineId});

  Certificate.fromJson(Map<String, dynamic> json) {
    machineId = json['machine_id']['stringValue'];
  }
}
