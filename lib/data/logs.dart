class Logs implements Comparable<Logs> {

  String studentNumber = 'N/A', workplaceId = 'N/A', workplaceName = 'N/A',
      datetime = 'N/A';

  Logs({required this.studentNumber, required this.workplaceId, required this.datetime});

  Logs.fromJson(Map<String, dynamic> json) {
    studentNumber = json['student number']['stringValue'];
    workplaceId = json['workplace_id']['integerValue'].toString();
    datetime = json['date']['timestampValue'];
  }

  int compareTo(Logs other) {
    int order = datetime.compareTo(other.datetime);
    return order;
  }
}

