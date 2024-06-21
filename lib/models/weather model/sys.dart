// ignore_for_file: public_member_api_docs, sort_constructors_first
class Sys {
  final String pod;

  Sys({required this.pod});

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(
      pod: json['pod'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pod': pod,
    };
  }

  @override
  String toString() => 'Sys(pod: $pod)';
}
