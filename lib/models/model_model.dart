class Model {
  int? id;
  String? name;
  double? heightCm;
  double? weightKg;
  String? gender;

  Model({this.id, this.name, this.heightCm, this.weightKg, this.gender});

  Model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    heightCm = json['height_cm'];
    weightKg = json['weight_kg'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['height_cm'] = heightCm;
    data['weight_kg'] = weightKg;
    data['gender'] = gender;
    return data;
  }
}
