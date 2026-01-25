import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_lab/style/color.dart';

class SizeSelector extends StatelessWidget {
  final String selectedSize; // Should be raw keys: "small", "normal", etc.
  final Function(String) onSelect;
  final bool isDark;

  const SizeSelector({
    super.key,
    required this.selectedSize,
    required this.onSelect,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    // Keep raw keys here for comparison
    final sizes = ["small", "normal", "large", "extra"];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: sizes.map((sizeKey) {
            // Compare using the raw key
            bool isActive = selectedSize == sizeKey;

            return GestureDetector(
              onTap: () => onSelect(sizeKey), // Send the raw key back
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isActive
                      ? (isDark ? AppColor.col4 : AppColor.col5)
                      : (isDark ? Colors.white10 : Colors.white),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isActive
                        ? Colors.transparent
                        : (isDark ? Colors.white24 : Colors.grey.shade300),
                  ),
                ),
                child: Text(
                  sizeKey.tr, // <--- Only translate here for display
                  style: TextStyle(
                    color: isActive ? Colors.white : Colors.grey,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
