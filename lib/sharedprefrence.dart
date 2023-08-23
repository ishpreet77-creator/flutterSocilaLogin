// import 'dart:ffi';

// import 'package:shared_preferences/shared_preferences.dart';

// void saveValue(String key, dynamic value) async {
//   final prefs = await SharedPreferences.getInstance();
//   if (value is String) {
//     await prefs.setString(key, value);
//   } else if (value is int) {
//     await prefs.setInt(key, value);
//   } else if (value is double) {
//     await prefs.setDouble(key, value);
//   } else if (value is bool) {
//     await prefs.setBool(key, value);
//   }
// }

// //GET VALUE FORM SHARED PREFRENCE
// Future<dynamic> getValue(String key) async {
//   final prefs = await SharedPreferences.getInstance();
//   return prefs.get(key);
// }

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static Future<void> saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<void> saveBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  static Future<bool?> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  static Future<void> saveInt(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  static Future<int?> getInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  static Future<void> saveDouble(String key, double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(key, value);
  }

  static Future<double?> getDouble(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key);
  }

  static Future<void> saveModel(String key, dynamic value) async {
  final prefs = await SharedPreferences.getInstance();
  final jsonString = value.toJson(); // Convert the model to JSON
  await prefs.setString(key, jsonString);
}

static Future<T?> getModel<T>(String key, T Function(Map<String, dynamic> json) fromJson) async {
  final prefs = await SharedPreferences.getInstance();
  final jsonString = prefs.getString(key);
  if (jsonString != null) {
    final jsonMap = json.decode(jsonString);
    final model = fromJson(jsonMap);
    return model;
  } else {
    return null;
  }
}


  // static Future<void> saveModel(String key, dynamic value) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final jsonString = value.toJson(); // Convert the model to JSON
  //   await prefs.setString(key, jsonString);
  // }

  // static Future<T?> getModel<T>(String key, T Function(Map<String, dynamic>) fromJson) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final jsonString = prefs.getString(key);
  //   if (jsonString != null) {
  //     final jsonMap = json.decode(jsonString);
  //     final model = fromJson(jsonMap);
  //     return model;
  //   } else {
  //     return null;
  //   }
  // }
}
