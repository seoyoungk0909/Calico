class Times {
  int? id;
  int? start;

  Times({this.id, this.start});

  Times.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    start = json['start'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['start'] = start;
    return data;
  }
}
