class Workspace {
  String id = 'N/A';
  String bldInformation = 'N/A',
      workspaceName = 'N/A',
      workspaceResponsible = 'N/A';

  Workspace(this.id, this.bldInformation, this.workspaceName,
      this.workspaceResponsible);

  Workspace.fromJson(Map<String, dynamic> json) {
    id = json['id']['stringValue'];
    bldInformation = json['room']['stringValue'];
    workspaceName = json['name']['stringValue'];
    workspaceResponsible = json['responsible']['stringValue'];
  }
}
