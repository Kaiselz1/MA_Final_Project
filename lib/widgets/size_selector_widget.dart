import 'package:flutter/material.dart';

class SizeSelector extends StatelessWidget {
  final String selectedSize;
  final Function(String) onSelect;

  const SizeSelector({super.key, required this.selectedSize, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final sizes = ["Small", "Normal", "Large", "Extra"];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: sizes.map((size) {
            bool isActive = selectedSize == size;
            return GestureDetector(
              onTap: () => onSelect(size),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  color: isActive ? const Color(0xFF6D5D51) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: isActive ? Colors.transparent : Colors.grey.shade300),
                ),
                child: Text(size, style: TextStyle(color: isActive ? Colors.white : Colors.black54)),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}