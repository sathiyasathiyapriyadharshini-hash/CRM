import 'dart:convert';
import 'package:crm/SignIn/splash.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
<<<<<<< HEAD
import 'package:crm/utils/preference_service.dart';
=======
import 'package:shared_preferences/shared_preferences.dart';
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342

class ProfileService {
  static const String _apiUrl = 'https://erpsmart.in/total/api/m_api/';

  static Future<Map<String, dynamic>?> fetchProfileData() async {
    try {
<<<<<<< HEAD
      final String? ledId = await PreferenceService.getLedId();
=======
      final prefs = await SharedPreferences.getInstance();
      final String ledId = prefs.getString('led_id') ?? '';
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
      final String deviceId = SplashScreen.deviceId ?? '3423';
      final String lt = SplashScreen.lt ?? '3232';
      final String ln = SplashScreen.ln ?? '332';

<<<<<<< HEAD
      if (ledId == null || ledId.isEmpty) {
        debugPrint(
          "ProfileService: led_id (from led_id/cus_id) is empty, skipping API call.",
        );
        return null;
      }

      String currentCid = await PreferenceService.getCid();
      String? token = await PreferenceService.getToken();

      final Map<String, String> body = {
        'type': '2071',
        'cid': currentCid,
=======
      if (ledId.isEmpty) {
        debugPrint("ProfileService: led_id is empty, skipping API call.");
        return null;
      }

      final Map<String, String> body = {
        'type': '2071',
        'cid': '21472147',
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
        'device_id': deviceId,
        'lt': lt,
        'ln': ln,
        'id': ledId,
<<<<<<< HEAD
        if (token != null) 'token': token,
=======
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
      };

      debugPrint("------------ GET PROFILE API REQUEST ------------");
      debugPrint("URL: $_apiUrl");
      debugPrint("BODY: $body");

      final response = await http.post(Uri.parse(_apiUrl), body: body);

<<<<<<< HEAD
      debugPrint("ProfileService: Response Body: ${response.body}");
=======
      debugPrint("------------ GET PROFILE API RESPONSE ------------");
      debugPrint("STATUS: ${response.statusCode}");
      debugPrint("BODY: ${response.body}");
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
<<<<<<< HEAD
          final data = responseData['data'];
          if (data != null) {
            await PreferenceService.setName(data['name']?.toString() ?? '');
            await PreferenceService.setEmail(data['email']?.toString() ?? '');
            await PreferenceService.setMobile(data['mobile']?.toString() ?? '');
            if (data['token'] != null) {
              await PreferenceService.setToken(data['token'].toString());
            }
          }
          return data;
=======
          return responseData['data'];
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
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
<<<<<<< HEAD
      final String? ledId = await PreferenceService.getLedId();
=======
      final prefs = await SharedPreferences.getInstance();
      final String ledId = prefs.getString('led_id') ?? '';
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
      final String deviceId = SplashScreen.deviceId ?? '3423';
      final String lt = SplashScreen.lt ?? '3232';
      final String ln = SplashScreen.ln ?? '332';

<<<<<<< HEAD
      if (ledId == null || ledId.isEmpty) {
        debugPrint(
          "ProfileService: led_id (from led_id/cus_id) is empty, skipping update API call.",
=======
      if (ledId.isEmpty) {
        debugPrint(
          "ProfileService: led_id is empty, skipping update API call.",
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
        );
        return null;
      }

<<<<<<< HEAD
      String currentCid = await PreferenceService.getCid();
      String? token = await PreferenceService.getToken();

      final Map<String, String> body = {
        'type': '3004',
        'cid': currentCid,
=======
      final Map<String, String> body = {
        'type': '3004',
        'cid': '21472147',
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
        'device_id': deviceId,
        'lt': lt,
        'ln': ln,
        'id': ledId,
        'name': name,
        'mobile': mobile,
        'email': email,
<<<<<<< HEAD
        if (token != null) 'token': token,
=======
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
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
<<<<<<< HEAD
        if (responseData['status'] == 'success') {
          await PreferenceService.setName(name);
          await PreferenceService.setEmail(email);
          await PreferenceService.setMobile(mobile);
        }
=======
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
        return responseData;
      }
      return null;
    } catch (e) {
      debugPrint("ProfileService Update Error: $e");
      return null;
    }
  }
}
