import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

String serializeMap(Map<String, dynamic> map) {
  map.forEach((key, value) {
    if (value is Timestamp) {
      map[key] = value.toDate().toIso8601String();
    }
  });
  return jsonEncode(map);
}

Map<String, dynamic> deserializeMap(String jsonString) {
  Map<String, dynamic> map = jsonDecode(jsonString) as Map<String, dynamic>;
  map.forEach((key, value) {
    if (value is String &&
        value.contains('-') &&
        value.contains('T') &&
        value.contains(':')) {
      map[key] = Timestamp.fromDate(DateTime.parse(value));
    }
  });
  return map;
}
