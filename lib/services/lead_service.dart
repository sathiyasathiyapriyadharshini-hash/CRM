import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../SignIn/splash.dart';
import '../utils/preference_service.dart';

class LeadService {
  static const String _apiUrl = 'https://erpsmart.in/total/api/m_api/';

  /// Safely attempts to decode a JSON response.
  /// Returns an error map if the body is not valid JSON.
  static Map<String, dynamic> _safeDecodeJson(String body) {
    try {
      // Extract JSON substring if there's extra content before/after
      int startIndex = body.indexOf('{');
      int endIndex = body.lastIndexOf('}');
      if (startIndex != -1 && endIndex != -1 && endIndex >= startIndex) {
        return json.decode(body.substring(startIndex, endIndex + 1));
      }
      // No JSON structure found — body is a plain text error
      debugPrint('Non-JSON response received: $body');
      return {
        'error': true,
        'error_msg':
            'Service is currently unavailable. Please try again later.',
      };
    } on FormatException catch (e) {
      debugPrint('JSON decode error: $e\nRaw body: $body');
      return {
        'error': true,
        'error_msg':
            'Service is currently unavailable. Please try again later.',
      };
    }
  }

  static Future<List<dynamic>> fetchFollowUpHistory({
    required String leadNo,
  }) async {
    try {
      String deviceId = SplashScreen.deviceId ?? '3453489';
      String ln = SplashScreen.ln ?? '43432323';
      String lt = SplashScreen.lt ?? '23233443';

      String currentCid = await PreferenceService.getCid();
      String? token = await PreferenceService.getToken();

      final Map<String, String> body = {
        'type': '3005',
        'cid': currentCid,
        'lt': lt,
        'ln': ln,
        'device_id': deviceId,
        'uid': '002', // Assuming UID 002 based on previous grep for 3003
        'no': leadNo,
        if (token != null) 'token': token,
      };

      debugPrint("------------ FETCH FOLLOW-UP HISTORY REQUEST ------------");
      debugPrint("URL: $_apiUrl");
      debugPrint("BODY: $body");

      final response = await http.post(Uri.parse(_apiUrl), body: body);

      debugPrint("------------ FETCH FOLLOW-UP HISTORY RESPONSE ------------");
      debugPrint("STATUS: ${response.statusCode}");
      debugPrint("BODY: ${response.body}");

      if (response.statusCode == 200) {
        String bodyText = response.body;

        // Robust sanitization
        int startIndex = bodyText.indexOf('{');
        int endIndex = bodyText.lastIndexOf('}');

        if (startIndex != -1 && endIndex != -1) {
          bodyText = bodyText.substring(startIndex, endIndex + 1);
        }

        final Map<String, dynamic> data = json.decode(bodyText);

        if (data['error'] == false && data['details'] != null) {
          return List<dynamic>.from(data['details']);
        } else {
          debugPrint("API Error: ${data['error_msg'] ?? 'Unknown error'}");
        }
      }
    } catch (e) {
      debugPrint("Error fetching follow-up history: $e");
    }
    return [];
  }

  static Future<Map<String, dynamic>> addLead(
    Map<String, String> leadData, {
    String apiType = '3011',
  }) async {
    try {
      String deviceId = SplashScreen.deviceId ?? '3453489';
      String ln = SplashScreen.ln ?? '43432323';
      String lt = SplashScreen.lt ?? '23233443';

      String currentCid = await PreferenceService.getCid();
      String? token = await PreferenceService.getToken();

      final Map<String, String> body = {
        'type': apiType,
        'cid': currentCid,
        'lt': lt,
        'ln': ln,
        'device_id': deviceId,
        if (token != null) 'token': token,
        ...leadData,
      };

      debugPrint("------------ ADD LEAD API REQUEST ------------");
      debugPrint("URL: $_apiUrl");
      debugPrint("BODY: $body");

      final response = await http.post(Uri.parse(_apiUrl), body: body);

      debugPrint("------------ ADD LEAD API RESPONSE ------------");
      debugPrint("STATUS: ${response.statusCode}");
      debugPrint("BODY: ${response.body}");

      if (response.statusCode == 200) {
        return _safeDecodeJson(response.body);
      } else {
        return {
          'error': true,
          'error_msg': 'Server error: ${response.statusCode}',
        };
      }
    } catch (e) {
      debugPrint("Error adding lead: $e");
      return {'error': true, 'error_msg': 'Connection error: $e'};
    }
  }

  static Future<List<dynamic>> fetchLeads({required String enquiryType}) async {
    try {
      String deviceId = SplashScreen.deviceId ?? '3453489';
      String ln = SplashScreen.ln ?? '43432323';
      String lt = SplashScreen.lt ?? '23233443';

      String currentCid = await PreferenceService.getCid();
      String? token = await PreferenceService.getToken();
      String? ledId = await PreferenceService.getLedId();

      // Determine API Type based on enquiryType
      // Lead: 3010, Enquiry: 3013
      final String apiType = enquiryType.toLowerCase() == 'enquiry'
          ? '3013'
          : '3010';

      final Map<String, String> body = {
        'type': apiType,
        'cid': currentCid,
        'lt': lt,

        'ln': ln,
        'device_id': deviceId,
        'enquiry_type': enquiryType,
        'led_id': ledId ?? '33',
        if (token != null) 'token': token,
      };

      debugPrint(
        "------------ FETCH LEADS API REQUEST ($enquiryType) ------------",
      );
      debugPrint("URL: $_apiUrl");
      debugPrint("BODY: $body");

      final response = await http.post(Uri.parse(_apiUrl), body: body);

      debugPrint("------------ FETCH LEADS API RESPONSE ------------");
      debugPrint("STATUS: ${response.statusCode}");
      debugPrint("BODY: ${response.body}");

      if (response.statusCode == 200) {
        String bodyText = response.body;

        // Robust sanitization
        int startIndex = bodyText.indexOf('{');
        int endIndex = bodyText.lastIndexOf('}');

        if (startIndex != -1 && endIndex != -1) {
          bodyText = bodyText.substring(startIndex, endIndex + 1);
        }

        final Map<String, dynamic> data = json.decode(bodyText);

        if (data['error'] == false && data['details'] != null) {
          return List<dynamic>.from(data['details']);
        } else {
          debugPrint("API Error: ${data['error_msg'] ?? 'Unknown error'}");
        }
      }
    } catch (e) {
      debugPrint("Error fetching leads: $e");
    }
    return [];
  }

  static Future<List<dynamic>> fetchFollowUpHistoryAll() async {
    try {
      String deviceId = SplashScreen.deviceId ?? '1234';
      String ln = SplashScreen.ln ?? '123';
      String lt = SplashScreen.lt ?? '456';

      String currentCid = await PreferenceService.getCid();
      String? token = await PreferenceService.getToken();
      String? ledId = await PreferenceService.getLedId();

      final Map<String, String> body = {
        'type': '3016',
        'cid': currentCid,
        'led_id': ledId ?? '33',
        'lt': lt,
        'ln': ln,
        'device_id': deviceId,
        if (token != null) 'token': token,
      };

      debugPrint(
        "------------ FETCH FOLLOW-UP HISTORY ALL REQUEST ------------",
      );
      debugPrint("URL: $_apiUrl");
      debugPrint("BODY: $body");

      final response = await http.post(Uri.parse(_apiUrl), body: body);

      debugPrint(
        "------------ FETCH FOLLOW-UP HISTORY ALL RESPONSE ------------",
      );
      debugPrint("STATUS: ${response.statusCode}");
      debugPrint("BODY: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = _safeDecodeJson(response.body);

        if (data['error'] == false && data['details'] != null) {
          return List<dynamic>.from(data['details']);
        } else {
          debugPrint("API Error: ${data['error_msg'] ?? 'Unknown error'}");
        }
      }
    } catch (e) {
      debugPrint("Error fetching follow-up history (3016): $e");
    }
    return [];
  }

  static Future<Map<String, dynamic>> addFollowUp(
    Map<String, dynamic> followUpData,
  ) async {
    try {
      String deviceId = SplashScreen.deviceId ?? '3453489';
      String ln = SplashScreen.ln ?? '43432323';
      String lt = SplashScreen.lt ?? '23233443';

      String currentCid = await PreferenceService.getCid();
      String? token = await PreferenceService.getToken();
      String? userLedId = await PreferenceService.getLedId();

      // For 3008 (Add):
      // led_id = current user's id (performing the action)
      // no = lead id (the target lead)
      String? leadIdFromData = followUpData['led_id']?.toString();

      final Map<String, String> body = {
        'type': '3008',
        'cid': currentCid,
        'led_id': (userLedId ?? '').toString(),
        if (leadIdFromData != null && leadIdFromData != 'null')
          'no': leadIdFromData,
        'lt': lt,
        'ln': ln,
        'device_id': deviceId,
        if (token != null) 'token': token,
        ...followUpData.map((key, value) {
          if (key == 'led_id') return MapEntry('none', ''); // skip
          String val = value.toString();
          return MapEntry(key, val == 'null' ? '' : val);
        }),
      };

      debugPrint("------------ ADD FOLLOW-UP API REQUEST ------------");
      debugPrint("URL: $_apiUrl");
      debugPrint("BODY: $body");

      final response = await http.post(Uri.parse(_apiUrl), body: body);

      debugPrint("------------ ADD FOLLOW-UP API RESPONSE ------------");
      debugPrint("STATUS: ${response.statusCode}");
      debugPrint("BODY: ${response.body}");

      if (response.statusCode == 200) {
        return _safeDecodeJson(response.body);
      } else {
        return {
          'error': true,
          'error_msg': 'Server error: ${response.statusCode}',
        };
      }
    } catch (e) {
      debugPrint("Error adding follow-up: $e");
      return {'error': true, 'error_msg': 'Connection error: $e'};
    }
  }

  static Future<Map<String, dynamic>> updateFollowUp(
    Map<String, dynamic> followUpData,
  ) async {
    try {
      String deviceId = SplashScreen.deviceId ?? '3453489';
      String ln = SplashScreen.ln ?? '43432323';
      String lt = SplashScreen.lt ?? '23233443';

      String currentCid = await PreferenceService.getCid();
      String? token = await PreferenceService.getToken();
      String? userLedId = await PreferenceService.getLedId();

      // For updates (3017):
      // id = followup record id (must come from followUpData)
      // led_id = current user's id (performing the action)
      String? recordId = followUpData['id']?.toString();

      final Map<String, String> body = {
        'type': '3017',
        'cid': currentCid,
        'led_id': (userLedId ?? '').toString(),
        'id': (recordId ?? '').toString(),
        'lt': lt,
        'ln': ln,
        'device_id': deviceId,
        if (token != null) 'token': token,
        ...followUpData.map((key, value) {
          if (key == 'led_id' || key == 'id')
            return MapEntry('none', ''); // skip
          String val = value.toString();
          return MapEntry(key, val == 'null' ? '' : val);
        }),
      };

      debugPrint("------------ UPDATE FOLLOW-UP API REQUEST ------------");
      debugPrint("URL: $_apiUrl");
      debugPrint("BODY: $body");

      final response = await http.post(Uri.parse(_apiUrl), body: body);

      debugPrint("------------ UPDATE FOLLOW-UP API RESPONSE ------------");
      debugPrint("STATUS: ${response.statusCode}");
      debugPrint("BODY: ${response.body}");

      if (response.statusCode == 200) {
        return _safeDecodeJson(response.body);
      } else {
        return {
          'error': true,
          'error_msg': 'Server error: ${response.statusCode}',
        };
      }
    } catch (e) {
      debugPrint("Error updating follow-up: $e");
      return {'error': true, 'error_msg': 'Connection error: $e'};
    }
  }

  static Future<List<dynamic>> fetchDropdownData({required String type}) async {
    try {
      String deviceId = SplashScreen.deviceId ?? '1234';
      String ln = SplashScreen.ln ?? '123';
      String lt = SplashScreen.lt ?? '456';

      String currentCid = await PreferenceService.getCid();
      String? token = await PreferenceService.getToken();

      final Map<String, String> body = {
        'type': type,
        'cid': currentCid,
        'lt': lt,
        'ln': ln,
        'device_id': deviceId,
        if (token != null) 'token': token,
      };

      debugPrint(
        "------------ FETCH DROPDOWN DATA REQUEST (Type: $type) ------------",
      );
      debugPrint("URL: $_apiUrl");
      debugPrint("BODY: $body");

      final response = await http.post(Uri.parse(_apiUrl), body: body);

      debugPrint(
        "------------ FETCH DROPDOWN DATA RESPONSE (Type: $type) ------------",
      );
      debugPrint("STATUS: ${response.statusCode}");
      debugPrint("BODY: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = _safeDecodeJson(response.body);

        if (data['error'] == false && data['details'] != null) {
          return List<dynamic>.from(data['details']);
        } else {
          debugPrint("API Error: ${data['error_msg'] ?? 'Unknown error'}");
        }
      }
    } catch (e) {
      debugPrint("Error fetching dropdown data (Type: $type): $e");
    }
    return [];
  }
}
