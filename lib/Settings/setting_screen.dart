import 'package:crm/Settings/account_setting_screen.dart';
import 'package:crm/Settings/notification_alert_screen.dart';
import 'package:crm/Settings/help_support_screen.dart';
import 'package:crm/Settings/security_settings_screen.dart';
import 'package:crm/Settings/app_preference_screen.dart';
import 'package:crm/SignIn/signin.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const SettingScreen({super.key, this.onBack});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF6B4195),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: widget.onBack ?? () => Navigator.pop(context),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Profile Header Section
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(color: Color(0xFF465583)),
            child: Row(
              children: [
                // Profile Image
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xFF871A1A), width: 2),
                    image: const DecorationImage(
                      image: AssetImage(
                        'assets/images/user_avatar.png',
                      ), // Placeholder for Harish's photo
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                // User Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Harish',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Edit',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.edit,
                            color: Colors.white70,
                            size: 12,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        '1122333444',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Text(
                            'View Full Profile',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          const SizedBox(width: 20),
                          // Active Badge (now specifically placed here)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF4CAF50),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'Active',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: Theme.of(context).dividerColor),

          // Settings List
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildSettingItem(
                  icon: 'assets/icons/acc_setting.png',
                  title: 'Account Setting',
                  iconColor: const Color(0xFF6B4195),
                ),
                _buildSettingItem(
                  icon: 'assets/icons/noti.png',
                  title: 'Notification & Alerts',
                  iconColor: Colors.orange,
                ),
                _buildSettingItem(
                  icon: 'assets/icons/help.png',
                  title: 'Help & Support',
                  iconColor: Colors.blue,
                ),
                _buildSettingItem(
                  icon: 'assets/icons/security.png',
                  title: 'Security & Settings',
                  iconColor: Colors.orangeAccent,
                ),
                _buildSettingItem(
                  icon: Icons.settings_applications_outlined,
                  title: 'App Preference',
                  iconColor: const Color(0xFF6B4195),
                ),
                _buildSettingItem(
                  icon: Icons.logout_outlined,
                  title: 'Logout',
                  iconColor: Colors.red,
                  isLastItem: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Theme.of(context).cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                Text(
                  'Are you sure want to Logout?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.titleLarge?.color,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 45,
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: Theme.of(context).dividerColor,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'NO',
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).textTheme.bodyLarge?.color,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: SizedBox(
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: Implement actual logout logic
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignInScreen(),
                              ),
                              (route) => false,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF23315D),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'YES',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSettingItem({
    required dynamic icon,
    required String title,
    required Color iconColor,
    bool isLastItem = false,
  }) {
    Widget leadingWidget;
    if (icon is IconData) {
      leadingWidget = Icon(icon, color: iconColor, size: 26);
    } else if (icon is String) {
      leadingWidget = Image.asset(icon, width: 26, height: 26);
    } else if (icon is ImageProvider) {
      leadingWidget = Image(image: icon, width: 26, height: 26);
    } else {
      leadingWidget = Icon(Icons.error, color: iconColor, size: 26);
    }

    return Column(
      children: [
        ListTile(
          leading: leadingWidget,
          title: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: Theme.of(context).textTheme.bodySmall?.color,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 8,
          ),
          onTap: () {
            if (title == 'Account Setting') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AccountSettingScreen()),
              );
            } else if (title == 'Notification & Alerts') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const NotificationAlertScreen(),
                ),
              );
            } else if (title == 'Help & Support') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HelpSupportScreen()),
              );
            } else if (title == 'Security & Settings') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SecuritySettingsScreen(),
                ),
              );
            } else if (title == 'App Preference') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AppPreferenceScreen()),
              );
            } else if (title == 'Logout') {
              _showLogoutDialog();
            }
          },
        ),
        Divider(
          height: 1,
          thickness: 1,
          indent: 20,
          endIndent: 20,
          color: Theme.of(context).dividerColor,
        ),
      ],
    );
  }
}
