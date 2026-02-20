import 'package:crm/SignIn/signin.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  static String? lt;
  static String? ln;
  static String? deviceId;

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? latitude;
  String? longitude;
  String? deviceId;
  bool _isLoading = true;
  String _statusMessage = "Initializing...";

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    while (mounted &&
        (latitude == null || longitude == null || deviceId == null)) {
      try {
        setState(() => _statusMessage = "Fetching Device ID...");
        await _fetchDeviceId();

        setState(() => _statusMessage = "Fetching Location...");
        await _fetchLocation();

        if (latitude == null || longitude == null) {
          // If we still don't have location, it might be because services are off or permission denied
          await Future.delayed(const Duration(seconds: 2));
          continue;
        }
      } catch (e) {
        debugPrint("Error fetching data: $e");
        setState(() => _statusMessage = "Error fetching details. Retrying...");
        await Future.delayed(const Duration(seconds: 2));
      }
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
        _statusMessage = "Done!";
      });
      _navigateToSignIn();
    }
  }

  Future<void> _fetchLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() => _statusMessage = "Please enable Location Services (GPS)");
      // Optionally open settings automatically or wait for user
      // await Geolocator.openLocationSettings();
      return;
    }

    // Check for permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      setState(() => _statusMessage = "Requesting Location Permission...");
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() => _statusMessage = "Location permission denied");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(
        () => _statusMessage =
            "Location permission permanently denied. Please enable in Settings.",
      );
      // await Geolocator.openAppSettings();
      return;
    }

    // If we have permission and service, get the position
    setState(() => _statusMessage = "Getting current location...");
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      if (mounted) {
        setState(() {
          latitude = position.latitude.toString();
          longitude = position.longitude.toString();
          SplashScreen.lt = latitude;
          SplashScreen.ln = longitude;
        });
      }

      final prefs = await SharedPreferences.getInstance();
      if (latitude != null && longitude != null) {
        await prefs.setString('lt', latitude!);
        await prefs.setString('ln', longitude!);
      }
      debugPrint("Lat: $latitude, Lon: $longitude");
    } catch (e) {
      debugPrint("Error getting position: $e");
      setState(() => _statusMessage = "Error getting location. Retrying...");
    }
  }

  Future<void> _fetchDeviceId() async {
    if (deviceId != null) return;

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.id;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor;
      }

      SplashScreen.deviceId = deviceId;

      if (deviceId != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('device_id', deviceId!);
      }
      debugPrint("Device ID: $deviceId");
    } catch (e) {
      debugPrint("Error fetching device ID: $e");
    }
  }

  void _navigateToSignIn() {
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignInScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double screenWidth = size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/smart.png', width: screenWidth * 0.6),
            const SizedBox(height: 10),
            Image.asset(
              'assets/images/TOTAL ERP.png',
              width: screenWidth * 0.35,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : null,
            ),
            const SizedBox(height: 40),
            if (_isLoading) ...[
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  _statusMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
