import 'dart:convert';
import 'dart:io';

void addKey(String key) {
  File file = File(
      '/Users/letaff/flutter projects/flutter-weather-app/assets/language.json');
  Map<String, dynamic> data =
      jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
  if (!data.containsKey(key)) {
    data.addAll({
      key: {'english': key, 'french': ''}
    });
    file.writeAsStringSync(jsonEncode(data));
  }
}