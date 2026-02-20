import 'dart:async';
import 'package:crm/Home/dashboard_screen.dart';
import 'package:crm/SignIn/signup.dart';
import 'package:crm/SignIn/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum LoginMethod { mobile, whatsapp, mail, sms }

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _inputController = TextEditingController();
  final FocusNode _inputFocusNode = FocusNode();
  LoginMethod _selectedMethod = LoginMethod.mobile;
  bool _isLoading = false;

  @override
  void dispose() {
    _inputFocusNode.dispose();
    _inputController.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn() async {
    if (_inputController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your details')),
      );
      return;
    }

    if (_selectedMethod != LoginMethod.mail &&
        _inputController.text.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid 10-digit number')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      String deviceId = SplashScreen.deviceId ?? '123456';
      String ln = SplashScreen.ln ?? '123';
      String lt = SplashScreen.lt ?? '123';
      String inputValue = _inputController.text.trim();

      const String apiUrl = 'https://erpsmart.in/total/api/m_api/';

      debugPrint("------------ SIGN IN API REQUEST ------------");
      debugPrint("URL: $apiUrl");
      debugPrint("TYPE: 3001");
      debugPrint("CID: 21472147");
      debugPrint("INPUT: $inputValue");
      debugPrint("METHOD: $_selectedMethod");
      debugPrint("DEVICE ID: $deviceId");
      debugPrint("LAT: $lt  LNG: $ln");

      Map<String, String> body = {
        'cid': '21472147',
        'type': '3001',
        'device_id': deviceId,
        'ln': ln,
        'lt': lt,
      };

      // Add the dynamic parameter based on login method
      if (_selectedMethod == LoginMethod.mail) {
        body['email'] = inputValue;
      } else if (_selectedMethod == LoginMethod.whatsapp) {
        body['wp_number'] = inputValue;
        body['number'] =
            inputValue; // Usually both are expected if not specified
      } else {
        body['number'] = inputValue;
      }

      final response = await http.post(Uri.parse(apiUrl), body: body);

      debugPrint("------------ SIGN IN API RESPONSE ------------");
      debugPrint("STATUS: ${response.statusCode}");
      debugPrint("BODY: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        bool error = responseData['error'] ?? true;
        String message = responseData['error_msg'] ?? 'Something went wrong';

        if (!error) {
          if (mounted) {
            _showOTPDialog();
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(message)));
          }
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Sign in failed (Server Error: ${response.statusCode})',
              ),
            ),
          );
        }
      }
    } catch (e) {
      debugPrint("Sign in error: $e");
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('An error occurred: $e')));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showOTPDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => OTPBottomSheet(
        inputValue: _inputController.text,
        isEmail: _selectedMethod == LoginMethod.mail,
        onWrongInput: () {
          Navigator.pop(context);
          _inputFocusNode.requestFocus();
        },
      ),
    );
  }

  String _getHintText() {
    switch (_selectedMethod) {
      case LoginMethod.mobile:
        return 'Enter Mobile Number';
      case LoginMethod.whatsapp:
        return 'Enter Whatsapp Number';
      case LoginMethod.mail:
        return 'Enter User Mail';
      case LoginMethod.sms:
        return 'Enter Mobile Number';
    }
  }

  TextInputType _getKeyboardType() {
    if (_selectedMethod == LoginMethod.mail) {
      return TextInputType.emailAddress;
    }
    return TextInputType.phone;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double screenHeight = size.height;
    final double screenWidth = size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.06,
                vertical: screenHeight * 0.02,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - (screenHeight * 0.04),
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: screenHeight * 0.15),
                      Image.asset(
                        'assets/images/smart.png',
                        width: screenWidth * 0.7,
                      ),
                      const SizedBox(height: 7),
                      Image.asset(
                        'assets/images/TOTAL ERP.png',
                        width: screenWidth * 0.45,
                      ),
                      SizedBox(height: screenHeight * 0.06),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sign in',
                              style: TextStyle(
                                fontSize: screenWidth * 0.045,
                                fontWeight: FontWeight.w600,
                                color:
                                    Theme.of(
                                      context,
                                    ).textTheme.titleLarge?.color ??
                                    Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Manage your customers, sales & business anywhere.',
                              style: TextStyle(
                                fontSize: screenWidth * 0.032,
                                color:
                                    (Theme.of(
                                              context,
                                            ).textTheme.bodyMedium?.color ??
                                            Colors.black)
                                        .withAlpha(178),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.045),
                      TextField(
                        controller: _inputController,
                        focusNode: _inputFocusNode,
                        keyboardType: _getKeyboardType(),
                        inputFormatters: _selectedMethod == LoginMethod.mail
                            ? null
                            : [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10),
                              ],
                        decoration: InputDecoration(
                          hintText: _getHintText(),
                          hintStyle: TextStyle(color: Color(0xffA2A2A2)),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffA2A2A2)),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF6B4195)),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.045),
                      SizedBox(
                        width: screenWidth * 0.7,
                        height: screenHeight * 0.065,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleSignIn,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6B4195),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  'Next',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenWidth * 0.04,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      Row(
                        children: [
                          const Expanded(child: Divider()),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              'or continue with',
                              style: TextStyle(
                                color:
                                    Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.color ??
                                    Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const Expanded(child: Divider()),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      Row(children: _buildMethodButtons()),
                      SizedBox(height: screenHeight * 0.05),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don’t Have An Account? ",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: screenWidth * 0.035,
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.color,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUpScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                color: const Color(0xFF000080),
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth * 0.035,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          children: [
                            Text(
                              'By Continuing you agree to our',
                              style: TextStyle(
                                color:
                                    Theme.of(
                                      context,
                                    ).textTheme.bodySmall?.color ??
                                    Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Text(
                              'Terms and Conditions',
                              style: TextStyle(
                                color: Color(0xFF6B4195),
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _buildMethodButtons() {
    List<Widget> buttons = [];

    if (_selectedMethod != LoginMethod.whatsapp) {
      buttons.add(
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              setState(() {
                _selectedMethod = LoginMethod.whatsapp;
              });
            },
            icon: Image.asset(
              'assets/icons/whats app.png',
              width: 20,
              height: 20,
            ),
            label: const Text(
              'Whatsapp',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Color(0xFF60D669), fontSize: 12),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: const Color(0xFF6B4195).withAlpha(127)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      );
    }

    if (_selectedMethod != LoginMethod.mail) {
      if (buttons.isNotEmpty) buttons.add(const SizedBox(width: 16));
      buttons.add(
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              setState(() {
                _selectedMethod = LoginMethod.mail;
              });
            },
            icon: const Icon(Icons.mail, color: Color(0xFF6B4195)),
            label: const Text(
              'Via Mail',
              style: TextStyle(color: Color(0xFF6B4195)),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: const Color(0xFF6B4195).withAlpha(127),
                width: 1.5,
              ),

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      );
    }

    if (_selectedMethod != LoginMethod.sms &&
        (_selectedMethod == LoginMethod.mail ||
            _selectedMethod == LoginMethod.whatsapp)) {
      if (buttons.isNotEmpty) buttons.add(const SizedBox(width: 16));
      buttons.add(
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              setState(() {
                _selectedMethod = LoginMethod.sms;
              });
            },
            icon: const Icon(Icons.smartphone, color: Color(0xFF6B4195)),
            label: const Text(
              'Via SMS',
              style: TextStyle(color: Color(0xFF6B4195)),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: const Color(0xFF6B4195).withAlpha(127)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      );
    }

    if (buttons.length == 1 && _selectedMethod == LoginMethod.mobile) {
      buttons.add(const SizedBox(width: 16));
      buttons.add(
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              setState(() {
                _selectedMethod = LoginMethod.sms;
              });
            },
            icon: const Icon(Icons.smartphone, color: Colors.blue),
            label: const Text(
              'Via SMS',
              style: TextStyle(color: Color(0xFF6B4195)),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: const Color(0xFF6B4195).withAlpha(127)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      );
    }

    return buttons;
  }
}

class OTPBottomSheet extends StatefulWidget {
  final String inputValue;
  final bool isEmail;
  final VoidCallback onWrongInput;
  const OTPBottomSheet({
    super.key,
    required this.inputValue,
    required this.onWrongInput,
    this.isEmail = false,
  });

  @override
  State<OTPBottomSheet> createState() => _OTPBottomSheetState();
}

class _OTPBottomSheetState extends State<OTPBottomSheet> {
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  int _timerSeconds = 60;
  Timer? _timer;
  late TapGestureRecognizer _tapRecognizer;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _tapRecognizer = TapGestureRecognizer()..onTap = widget.onWrongInput;
  }

  @override
  void dispose() {
    _timer?.cancel();
    _tapRecognizer.dispose();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() {
      _timerSeconds = 60;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timerSeconds > 0) {
          _timerSeconds--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  String _formatTimer() {
    int minutes = _timerSeconds ~/ 60;
    int seconds = _timerSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                  style: IconButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey[800]
                        : Colors.grey[300],
                    padding: const EdgeInsets.all(12),
                  ),
                ),
                const SizedBox(width: 16),
                const Text(
                  'Verify with OTP',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 30),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  color:
                      (Theme.of(context).textTheme.bodyMedium?.color ??
                              Colors.black)
                          .withOpacity(0.7),
                  fontSize: screenWidth * 0.035,
                ),
                children: [
                  TextSpan(
                    text: widget.isEmail
                        ? 'Waiting to automatically detect an OTP sent to your mail\n${widget.inputValue}. '
                        : 'Waiting to automatically detect an OTP sent to\n+91 ${widget.inputValue}. ',
                  ),
                  TextSpan(
                    text: widget.isEmail ? 'Wrong Email?' : 'Wrong Number?',
                    recognizer: _tapRecognizer,
                    style: TextStyle(
                      color: Colors.blue[900],
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.035,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                6,
                (index) => SizedBox(
                  width: 45,
                  child: TextField(
                    controller: _otpControllers[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                    decoration: InputDecoration(
                      counterText: "",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFF6B4195)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color(0xFF6B4195),
                          width: 2,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 5) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: _timerSeconds == 0 ? _startTimer : null,
                  child: Text(
                    'Resend OTP',
                    style: TextStyle(
                      color: _timerSeconds == 0
                          ? const Color(0xFF6B4195)
                          : (Theme.of(context).textTheme.bodyMedium?.color ??
                                    Colors.black)
                                .withOpacity(0.7),
                      fontWeight: _timerSeconds == 0
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
                Text(
                  _formatTimer(),
                  style: const TextStyle(
                    color: Color(0xFF6B4195),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  String otp = _otpControllers
                      .map((controller) => controller.text)
                      .join();
                  if (otp.length == 6) {
                    Navigator.pop(context); // Close OTP bottom sheet
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DashboardScreen(),
                      ),
                      (route) => false,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter 6-digit OTP')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6B4195),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Verify',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
