import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
          // Header background + Row
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

          // Floating search bar (optional)
          if (showSearchBar)
            Positioned(
              bottom: -25,
              left: 20,
              right: 20,
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  onChanged: onSearchChanged,
                  decoration: InputDecoration(
                    icon: Icon(Icons.search, size: 30, color: AppColor.col5),
                    hintText: 'Search drink',
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      onPressed: onCategoryTap,
                      icon: SvgPicture.asset(
                        'assets/icons/category.svg',
                        width: 25,
                        height: 25,
                        color: AppColor.col5,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
