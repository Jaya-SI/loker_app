import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../common/shared_code.dart';
import '../model/auth_model.dart';
import '../model/pelamar_model.dart';

class SharedPreferencesService {
  static Future<SharedPreferences> get _instance async =>
      prefs ??= await SharedPreferences.getInstance();
  static SharedPreferences? prefs;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    prefs = await _instance;
    return prefs ?? await SharedPreferences.getInstance();
  }

  static AuthModel? getAuthModel() {
    String? authJson = prefs?.getString(SharedCode.authJson);
    if (authJson != null) {
      AuthModel authModel = authModelFromJson(authJson);
      return authModel;
    }
    return null;
  }

  static AuthPelamarModel? getAuthPelamarModel() {
    String? authJsonPelamar = prefs?.getString(SharedCode.authJsonPelamar);
    if (authJsonPelamar != null) {
      AuthPelamarModel authModel = authPelamarModelFromJson(authJsonPelamar)!;
      return authModel;
    }
    return null;
  }

  static Future<void> setAuthModel(AuthModel authModel) async {
    await prefs?.setString(SharedCode.authJson, jsonEncode(authModel.toJson()));
  }

  static Future<void> setAuthPelamarModel(AuthPelamarModel authModel) async {
    await prefs?.setString(SharedCode.authJsonPelamar, jsonEncode(authModel.toJson()));
  }

  static Future<void> clearAllPrefs() async {
    await prefs?.clear();
  }
}
