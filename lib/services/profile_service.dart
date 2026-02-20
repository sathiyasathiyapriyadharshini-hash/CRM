import 'dart:convert';
import 'package:crm/SignIn/splash.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileService {
  static const String _apiUrl = 'https://erpsmart.in/total/api/m_api/';

  static Future<Map<String, dynamic>?> fetchProfileData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String ledId = prefs.getString('led_id') ?? '';
      final String deviceId = SplashScreen.deviceId ?? '3423';
      final String lt = SplashScreen.lt ?? '3232';
      final String ln = SplashScreen.ln ?? '332';

      if (ledId.isEmpty) {
        debugPrint("ProfileService: led_id is empty, skipping API call.");
        return null;
      }

      final Map<String, String> body = {
        'type': '2071',
        'cid': '21472147',
        'device_id': deviceId,
        'lt': lt,
        'ln': ln,
        'id': ledId,
      };

      debugPrint("------------ GET PROFILE API REQUEST ------------");
      debugPrint("URL: $_apiUrl");
      debugPrint("BODY: $body");

      final response = await http.post(Uri.parse(_apiUrl), body: body);

      debugPrint("------------ GET PROFILE API RESPONSE ------------");
      debugPrint("STATUS: ${response.statusCode}");
      debugPrint("BODY: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          return responseData['data'];
        }
      }
      return null;
    } catch (e) {
      debugPrint("ProfileService Error: $e");
      return null;
    }
  }

  static Future<Map<String, dynamic>?> updateProfileData({
    required String name,
    required String mobile,
    required String email,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String ledId = prefs.getString('led_id') ?? '';
      final String deviceId = SplashScreen.deviceId ?? '3423';
      final String lt = SplashScreen.lt ?? '3232';
      final String ln = SplashScreen.ln ?? '332';

      if (ledId.isEmpty) {
        debugPrint(
          "ProfileService: led_id is empty, skipping update API call.",
        );
        return null;
      }

      final Map<String, String> body = {
        'type': '3004',
        'cid': '21472147',
        'device_id': deviceId,
        'lt': lt,
        'ln': ln,
        'id': ledId,
        'name': name,
        'mobile': mobile,
        'email': email,
      };

      debugPrint("------------ UPDATE PROFILE API REQUEST ------------");
      debugPrint("URL: $_apiUrl");
      debugPrint("BODY: $body");

      final response = await http.post(Uri.parse(_apiUrl), body: body);

      debugPrint("------------ UPDATE PROFILE API RESPONSE ------------");
      debugPrint("STATUS: ${response.statusCode}");
      debugPrint("BODY: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      }
      return null;
    } catch (e) {
      debugPrint("ProfileService Update Error: $e");
      return null;
    }
  }
}
