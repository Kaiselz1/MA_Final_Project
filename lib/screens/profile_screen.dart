import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:pos_lab/screens/cart_screen.dart';
import 'package:pos_lab/style/color.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  bool isLoading = true;
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.col8,
      appBar: AppBar(
        backgroundColor: AppColor.col6,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: AppColor.col4),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.col5,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 78,
                              height: 78,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColor.col3,
                                  width: 3,
                                ),
                              ),
                            ),
                            const CircleAvatar(
                              radius: 34,
                              backgroundColor: Color(0xFFBDBDBD),
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 36,
                              ),
                            ),
                            Positioned(
                              right: 4,
                              bottom: 4,
                              child: Container(
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                  color: AppColor.col4,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.edit,
                                  size: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "Username", // Replace with Real username
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Jeff_Epstein@gmail.com", // Replace with Real gmail
                          style: TextStyle(color: AppColor.col8, fontSize: 12),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              _profileMenuItem(
                titleColor: Colors.black,
                iconColor: Colors.black,
                icon: Icons.lock_outline,
                title: "Change Information",
                onTap: () {},
              ),

              const SizedBox(height: 8),
              _profileMenuItem(
                icon: Icons.logout,
                title: "Log Out",
                titleColor: Colors.black,
                iconColor: Colors.red,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        color: Colors.white,
        elevation: 12,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: BottomNavItem(icon: Icons.home_filled,
                 onTap: () {
                  
                    //add home screen

                },
                
                
                ),

              ),
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: BottomNavItem(icon: CupertinoIcons.cart,
                 onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const CartScreen()),
                  );
                },
                 ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: BottomNavItem(icon: Icons.history,
                onTap: () {

                 //History Screen

                },
                
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: BottomNavItem(icon: CupertinoIcons.heart_fill,
                 onTap: () {

                  //Favorite Screen

                },
                 
                 ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: BottomNavItem(icon: Icons.person,
                onTap: () {
                 
                },
                ),

              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? titleColor,
    Color? iconColor,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFFF2F2F2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 18, color: iconColor ?? Colors.black),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: titleColor ?? Colors.black,
                ),
              ),
            ),
            Icon(Icons.chevron_right, color: titleColor ?? Colors.black54),
          ],
        ),
      ),
    );
  }


//Change Bottom Nav Item




}


class BottomNavItem extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isActive;

  const BottomNavItem({
    super.key,
    required this.icon,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Icon(
          icon,
          size: 25,
          color: isActive ? AppColor.col4 : Colors.black,
        ),
      ),
    );
  }
}