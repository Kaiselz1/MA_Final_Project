import 'package:flutter/material.dart';
import 'package:pos_lab/style/color.dart';

class AppHeader extends StatelessWidget {
  final String name;
  final String email;
  final VoidCallback? onMenuTap;
  final Function(String)? onSearchChanged;
  final VoidCallback? onCategoryTap;
  final bool showSearchBar;

  const AppHeader({
    super.key,
    required this.name,
    required this.email,
    this.onMenuTap,
    this.onSearchChanged,
    this.onCategoryTap,
    this.showSearchBar = true,
  });

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 40),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColor.col6, AppColor.col5],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: onMenuTap,
                  child: Icon(Icons.menu, color: AppColor.col4, size: 35),
                ),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        color: AppColor.col4,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      email,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Center(
                    child: CircleAvatar(
                      radius: 18,
                      backgroundImage: AssetImage(
                        'assets/images/profiles/johnnoon.png',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class AppTitleHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onBackTap;

  const AppTitleHeader({
    super.key,
    required this.title,
    this.onBackTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120, 
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColor.col6, AppColor.col5],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                GestureDetector(
                  onTap: onBackTap ?? () => Navigator.of(context).maybePop(),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: AppColor.col4,
                    size: 26,
                  ),
                ),
                const Spacer(),
                Text(
                  title,
                  style: TextStyle(
                    color: AppColor.col4,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


