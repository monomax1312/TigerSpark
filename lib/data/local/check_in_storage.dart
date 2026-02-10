import 'dart:convert';

import '../models/check_in_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _keyCheckIns = 'tiger_spark_check_ins';

class CheckInStorage {
  CheckInStorage(this._prefs);

  final SharedPreferences _prefs;

  Future<List<CheckInDto>> load() async {
    final raw = _prefs.getString(_keyCheckIns);
    if (raw == null || raw.isEmpty) return [];
    final list = jsonDecode(raw) as List<dynamic>;
    return list.map((e) => CheckInDto.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> save(List<CheckInDto> list) async {
    final encoded = jsonEncode(list.map((e) => e.toJson()).toList());
    await _prefs.setString(_keyCheckIns, encoded);
  }
}
