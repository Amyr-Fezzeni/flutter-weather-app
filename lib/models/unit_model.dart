
class UnitModel {
  String name;
  String code;
  String description;
  UnitModel({
    required this.name,
    required this.code,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'code': code,
      'description': description,
    };
  }

  factory UnitModel.fromMap(Map<String, dynamic> map) {
    return UnitModel(
      name: map['name'] as String,
      code: map['code'] as String,
      description: map['description'] as String,
    );
  }
}
