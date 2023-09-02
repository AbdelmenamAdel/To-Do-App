import 'package:shared_preferences/shared_preferences.dart';

//! CacheHelper That's Connect and Talk to local database.

class CacheHelper {
  late SharedPreferences sharedPreferences;

//! Initialization of Cache
  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

//! PutData into local database using key
  Future<dynamic> putData({
    required String key,
    required dynamic value,
  }) async {
    if (value is int) {
      return await sharedPreferences.setInt(key, value);
    } else if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    } else if (value is String) {
      return await sharedPreferences.setString(key, value);
    } else {
      return await sharedPreferences.setDouble(key, value);
    }
  }

//! SetData in local database using key
  Future<bool> setData({
    required String key,
    required value,
  }) async {
    if (value is int) {
      await sharedPreferences.setInt(key, value);
      return true;
    } else if (value is bool) {
      await sharedPreferences.setBool(key, value);
      return true;
    } else if (value is String) {
      await sharedPreferences.setString(key, value);
      return true;
    } else if (value is double) {
      await sharedPreferences.setDouble(key, value);
      return true;
    } else {
      return false;
    }
  }

//! SaveData in local database
  Future<bool> saveData({
    required String key,
    required value,
  }) async {
    if (value is int) {
      return await sharedPreferences.setInt(key, value);
    } else if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    } else if (value is String) {
      return await sharedPreferences.setString(key, value);
    } else {
      return await sharedPreferences.setDouble(key, value);
    }
  }

//! GetData as a string
  String? getDataString({
    required String key,
  }) {
    return sharedPreferences.getString(key);
  }

//! GetData that already saved in local database as an Object
  dynamic getData({
    required String key,
  }) {
    return sharedPreferences.get(key);
  }

//! ContainsKey
  Future<bool> containsKey({
    required String key,
  }) async {
    return sharedPreferences.containsKey(key);
  }

//! ClearData from database using specific key
  void clearData() {
    sharedPreferences.clear();
  }

//! RemoveData from database using specific key
  void removeData({
    required String key,
  }) {
    sharedPreferences.remove(key);
  }
}
