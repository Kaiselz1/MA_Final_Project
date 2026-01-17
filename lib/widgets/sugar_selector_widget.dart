import 'package:flutter/material.dart';
import 'package:pos_lab/style/color.dart';

enum SugarMode { none, percentage, sweetness }

class SugarSelector extends StatelessWidget {
  final SugarMode activeMode;
  final double percentage;
  final String selectedSweetness;
  final bool showSlider;
  final Function(SugarMode, {double? percent, String? sweetness, bool? toggleSlider}) onChanged;

  const SugarSelector({
    super.key,
    required this.activeMode,
    required this.percentage,
    required this.selectedSweetness,
    required this.showSlider,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> sweetnessOptions = [
      "Less Sweet", "Normal+", "Standard", "Sweet", "Extra Sweet", "Double Sugar"
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Row(
          children: [
            _buildBtn("No Sugar", SugarMode.none),
            const SizedBox(width: 10),
            _buildBtn("${percentage.toInt()}%", SugarMode.percentage, isPercent: true),
            const SizedBox(width: 10),
            _buildSweetnessDropdown(context, sweetnessOptions),
          ],
        ),
        
        // Dynamic Slider Section
        if (activeMode == SugarMode.percentage && showSlider) ...[
          const SizedBox(height: 10),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: const Color(0xFF6D5D51),
              thumbColor: const Color(0xFF6D5D51),
            ),
            child: Slider(
              value: percentage,
              min: 0,
              max: 100,
              onChanged: (val) {
                if (val == 0) {
                  onChanged(SugarMode.none, percent: 0, toggleSlider: false);
                } else {
                  onChanged(SugarMode.percentage, percent: val, toggleSlider: true);
                }
              },
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildBtn(String label, SugarMode mode, {bool isPercent = false}) {
    bool isActive = activeMode == mode;
    return GestureDetector(
      onTap: () => onChanged(mode, toggleSlider: isPercent ? !showSlider : false),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppColor.col5 : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isActive ? Colors.transparent : Colors.grey.shade300),
        ),
        child: Text(label, style: TextStyle(color: isActive ? Colors.white : Colors.grey)),
      ),
    );
  }

  Widget _buildSweetnessDropdown(BuildContext context, List<String> options) {
    bool isActive = activeMode == SugarMode.sweetness;
    return PopupMenuButton<String>(
      onSelected: (val) => onChanged(SugarMode.sweetness, sweetness: val, toggleSlider: false),
      itemBuilder: (context) => options.map((opt) => PopupMenuItem(value: opt, child: Text(opt))).toList(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF6D5D51) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isActive ? Colors.transparent : Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Text(isActive ? selectedSweetness : "Sweetness", 
                 style: TextStyle(color: isActive ? Colors.white : Colors.grey)),
            Icon(Icons.arrow_drop_down, color: isActive ? Colors.white : Colors.grey),
          ],
        ),
      ),
    );
  }
}