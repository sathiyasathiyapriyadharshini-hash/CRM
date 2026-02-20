import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../SignIn/splash.dart';

class LeadService {
  static const String _apiUrl = 'https://erpsmart.in/total/api/m_api/';

  static Future<List<dynamic>> fetchFollowUpHistory({
    required String leadNo,
  }) async {
    try {
      String deviceId = SplashScreen.deviceId ?? '3453489';
      String ln = SplashScreen.ln ?? '43432323';
      String lt = SplashScreen.lt ?? '23233443';

      final Map<String, String> body = {
        'type': '3005',
        'cid': '21472147',
        'lt': lt,
        'ln': ln,
        'device_id': deviceId,
        'uid': '002', // Assuming UID 002 based on previous grep for 3003
        'no': leadNo,
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
}
