import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


import '../../features/users/data/models/user_model.dart';

class AppStorage {
  /// This will store the user detail in memory anytime user opens the app
  static UserModel? currentUserSession;

// Create storage
  static const storage =  FlutterSecureStorage();

  static const String _authToken = "accessToken";

  static setAuthTokenVal(String value) async => await storage.write(key: _authToken, value: value);

  static Future<String> getAuthTokenVal() async {
    // use token
    return await storage.read(key: _authToken) ?? '';
  }


  static Future<void> save({required String key, required Map<String, dynamic> jsonValue}) async{
    // Write value
    await storage.write(key: key, value: json.encode(jsonValue));
  }

  static Future<Map<String, dynamic>?> get({required String key}) async {
// Read value
    String? value = await storage.read(key: key);
    if(value != null){
      return json.decode(value);
    }
    return null;
  }

  static remove({required String key}) async {
    // Delete value
    await storage.delete(key: key);
  }




}