import 'package:flutter/material.dart';
import 'package:hemmah_app/screens/Custom_navbar';
import 'package:hemmah_app/screens/about_screen.dart';
import 'package:hemmah_app/screens/change_password_step2.dart';
import 'package:hemmah_app/screens/chat_screen.dart';
import 'package:hemmah_app/screens/edit_profile_screen.dart';
import 'package:hemmah_app/screens/home_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final supabase = Supabase.instance.client;
  String name = '';
  String email = '';
  bool notificationsEnabled = true;
  bool isLightMode = true;

  // Set selectedIndex to 2 for settings page
  int selectedIndex = 2;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = supabase.auth.currentUser;
    final userMeta = user?.userMetadata;
    setState(() {
      name = userMeta?['name'] ?? 'User';
      email = user?.email ?? 'example@email.com';
    });
  }

  // Handle navigation
  void onItemTapped(int index) {
    if (index == selectedIndex) return;

    Widget screen;

    switch (index) {
      case 0:
        screen = HomeScreen(userName: name);
        break;
      case 1:
        // Handle add service or whatever is appropriate
        return;
      case 2:
        // Already on settings
        return;
      case 3:
        screen = const MessageScreen();
        break;
      default:
        return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00C180),
      body: Column(
        children: [
          const SizedBox(height: 60),
          const CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 50, color: Color(0xFF00C180)),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            email,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: [
                  const Text(
                    'اعدادات الحساب',
                    style: TextStyle(
                      color: Color(0xFF00C180),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditProfileScreen(),
                        ),
                      ).then((_) {
                        _loadUserData();
                      });
                    },
                    child: _buildSettingRow(
                      'تعديل الحساب',
                      Icons.arrow_forward_ios,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChangePasswordStep2(),
                        ),
                      ).then((_) {
                        _loadUserData();
                      });
                    },
                    child: _buildSettingRow(
                      'تغيير كلمة المرور',
                      Icons.arrow_forward_ios,
                    ),
                  ),
                  const Divider(height: 40),
                  const Text(
                    'المزيد',
                    style: TextStyle(
                      color: Color(0xFF00C180),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AboutUsScreen(),
                        ),
                      );
                    },
                    child: _buildSettingRow('من نحن', Icons.arrow_forward_ios),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'اصدار 1.0.0',
                      style: TextStyle(color: Colors.grey.shade500),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      extendBody: true,
      // bottomNavigationBar: CustomBottomNavBar(
      //   selectedIndex: selectedIndex,
      //   onItemTapped: onItemTapped,
      // ),
    );
  }

  Widget _buildSettingRow(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16)),
          Icon(icon, size: 20, color: Colors.grey.shade600),
        ],
      ),
    );
  }

  Widget _buildSwitchRow(
    String title,
    bool value,
    Function(bool) onChanged, {
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16)),
          Row(
            children: [
              if (icon != null)
                Icon(icon, size: 18, color: Colors.grey.shade600),
              Switch(
                value: value,
                onChanged: onChanged,
                activeColor: const Color(0xFF00C180),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
