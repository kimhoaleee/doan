// ignore_for_file: use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../../constants.dart';
import '../auth/login_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  String _selectedLanguage = "English";
  String _selectedCurrency = "USD";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Settings", style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader("Account"),
            _buildSettingsCard(
              children: [
                _buildSettingsItem(
                  icon: Icons.person,
                  title: "Personal Information",
                  onTap: () {
                    // Navigate to profile screen
                  },
                ),
                _buildDivider(),
                _buildSettingsItem(
                  icon: Icons.location_on,
                  title: "Delivery Addresses",
                  onTap: () {
                    // Navigate to addresses screen
                  },
                ),
                _buildDivider(),
                _buildSettingsItem(
                  icon: Icons.payment,
                  title: "Payment Methods",
                  onTap: () {
                    // Navigate to payment methods screen
                  },
                ),
              ],
            ),
            _buildSectionHeader("Preferences"),
            _buildSettingsCard(
              children: [
                _buildSwitchItem(
                  icon: Icons.notifications,
                  title: "Push Notifications",
                  value: _notificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      _notificationsEnabled = value;
                    });
                  },
                ),
                _buildDivider(),
                _buildSwitchItem(
                  icon: Icons.dark_mode,
                  title: "Dark Mode",
                  value: _darkModeEnabled,
                  onChanged: (value) {
                    setState(() {
                      _darkModeEnabled = value;
                    });
                  },
                ),
                _buildDivider(),
                _buildDropdownItem(
                  icon: Icons.language,
                  title: "Language",
                  value: _selectedLanguage,
                  items: ["English", "Vietnamese", "French", "Spanish"],
                  onChanged: (value) {
                    setState(() {
                      _selectedLanguage = value!;
                    });
                  },
                ),
                _buildDivider(),
                _buildDropdownItem(
                  icon: Icons.attach_money,
                  title: "Currency",
                  value: _selectedCurrency,
                  items: ["USD", "VND", "EUR", "GBP"],
                  onChanged: (value) {
                    setState(() {
                      _selectedCurrency = value!;
                    });
                  },
                ),
              ],
            ),
            _buildSectionHeader("Support"),
            _buildSettingsCard(
              children: [
                _buildSettingsItem(
                  icon: Icons.help,
                  title: "Help Center",
                  onTap: () {
                    // Navigate to help center
                  },
                ),
                _buildDivider(),
                _buildSettingsItem(
                  icon: Icons.chat_bubble,
                  title: "Contact Us",
                  onTap: () {
                    // Navigate to contact us
                  },
                ),
                _buildDivider(),
                _buildSettingsItem(
                  icon: Icons.privacy_tip,
                  title: "Privacy Policy",
                  onTap: () {
                    // Navigate to privacy policy
                  },
                ),
                _buildDivider(),
                _buildSettingsItem(
                  icon: Icons.description,
                  title: "Terms & Conditions",
                  onTap: () {
                    // Navigate to terms and conditions
                  },
                ),
              ],
            ),
            _buildSectionHeader(""),
            _buildSettingsCard(
              children: [
                _buildSettingsItem(
                  icon: Icons.logout,
                  title: "Logout",
                  iconColor: Colors.red,
                  textColor: Colors.red,
                  onTap: () {
                    _showLogoutDialog(context);
                  },
                ),
              ],
            ),
            SizedBox(height: defaultPadding * 2),
            Center(
              child: Text(
                "App Version 1.0.0",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
            SizedBox(height: defaultPadding),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        defaultPadding,
        defaultPadding,
        defaultPadding,
        defaultPadding / 2,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
    );
  }

  Widget _buildSettingsCard({required List<Widget> children}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: defaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    Color iconColor = Colors.black54,
    Color textColor = Colors.black,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(title, style: TextStyle(color: textColor)),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }

  Widget _buildSwitchItem({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.black54),
      title: Text(title),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: primaryColor,
      ),
    );
  }

  Widget _buildDropdownItem<T>({
    required IconData icon,
    required String title,
    required T value,
    required List<T> items,
    required ValueChanged<T?> onChanged,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.black54),
      title: Text(title),
      trailing: DropdownButton<T>(
        value: value,
        underline: SizedBox(),
        icon: Icon(Icons.keyboard_arrow_down),
        items:
            items.map<DropdownMenuItem<T>>((T item) {
              return DropdownMenuItem<T>(
                value: item,
                child: Text(item.toString()),
              );
            }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, thickness: 1, indent: 70, endIndent: 0);
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
              child: Text("Logout"),
            ),
          ],
        );
      },
    );
  }
}
