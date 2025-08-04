import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'classData.dart';

class KeyValueStringStorage {
  // Save a string value with a key
  Future<void> save(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  // Retrieve a string value by key
  Future<String?> get(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  // Remove a value by key
  Future<void> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  // Optional: check if a key exists
  Future<bool> contains(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  Future<List<List<Question>>> getHistory() async {
    final data = await get("historyData");

    if (data == null || data.isEmpty) return [];

    try {
      final List<dynamic> outerList = jsonDecode(data);

      return outerList.map<List<Question>>((inner) {
        return (inner as List<dynamic>)
            .map<Question>((item) => Question.fromJson(item))
            .toList();
      }).toList();
    } catch (e) {
      print("Error parsing history data: $e");
      return [];
    }
  }


Future<void> saveHistory(List<Question> toAskQuestions) async {
  List<List<Question>> historyQuestion = await getHistory();
  historyQuestion.add(toAskQuestions);
  // Convert List<List<Question>> to List<List<Map<String, dynamic>>>
  final encoded = jsonEncode(
    historyQuestion.map(
          (questionList) => questionList.map((q) => q.toJson()).toList(),
    ).toList(),
  );
  await save("historyData", encoded);
  }


}
