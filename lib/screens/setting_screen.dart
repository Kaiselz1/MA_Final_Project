import 'package:flutter/material.dart';
import 'package:pos_lab/screens/login_screen.dart';
import 'package:pos_lab/style/color.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isDarkMode = true;
  String selectedLanguage = "English";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Header Row (Profile & Close) ---
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/profiles/johnnoon.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          "John Noon",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColor.col5,
                          ),
                        ),
                        Text(
                          "johnnoon77@gmail.com",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close, size: 40, color: AppColor.col5),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: 120,
                height: 30,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.col5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 2,
                  ),
                  child: const Text(
                    "Edit Profile",
                    style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const Divider(height: 40),

              Text(
                "Theme",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColor.col5,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5),
              _buildToggleOption(
                label: "Light",
                isActive: !isDarkMode,
                onChanged: (val) {
                  if (val) setState(() => isDarkMode = false);
                },
              ),
              _buildToggleOption(
                label: "Dark",
                isActive: isDarkMode,
                onChanged: (val) {
                  if (val) setState(() => isDarkMode = true);
                },
              ),
              const Divider(height: 20),

              Text(
                "Language",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColor.col5,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5),
              _buildToggleOption(
                label: "English",
                isActive: selectedLanguage == "English",
                onChanged: (val) {
                  if (val) setState(() => selectedLanguage = "English");
                },
              ),
              _buildToggleOption(
                label: "Khmer",
                isActive: selectedLanguage == "Khmer",
                onChanged: (val) {
                  if (val) setState(() => selectedLanguage = "Khmer");
                },
              ),
              const Divider(height: 20),

              // --- Contact Info Section ---
              _buildContactItem(Icons.telegram, "095 445 770"),
              _buildContactItem(Icons.phone, "095 445 770"),
              _buildContactItem(Icons.email, "basswalker76@gmail.com"),
              _buildContactItem(Icons.facebook, "Sokphonai Ny"),

              const SizedBox(height: 20),

              // --- Sign Out Button ---
              Center(
                child: SizedBox(
                  width: 200,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.col5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 2,
                    ),
                    child: const Text(
                      "Sign Out",
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // --- REUSABLE COMPONENTS ---

  Widget _buildToggleOption({
    required String label,
    required bool isActive,
    required Function(bool) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.black : Colors.grey,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              fontSize: 16,
            ),
          ),
          const Spacer(),
          Switch(
            value: isActive,
            onChanged: onChanged,
            activeColor: AppColor.col5,
          ),
        ],
      ),
    );
  }



  // Helper Widget for Contact Items
  Widget _buildContactItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18, // Increased radius
            backgroundColor: AppColor.col5.withOpacity(0.1),
            child: Icon(
              icon,
              size: 22, // Increased icon size
              color: AppColor.col5,
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 16, // Increased font size
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}