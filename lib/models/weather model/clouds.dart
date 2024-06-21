// ignore_for_file: public_member_api_docs, sort_constructors_first
class Clouds {
  final int all;

  Clouds({required this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(
      all: json['all'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'all': all,
    };
  }

  @override
  String toString() => 'Clouds(all: $all)';
}
