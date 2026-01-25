import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_lab/controllers/setting_controller.dart';
import 'package:pos_lab/models/cart_items.dart';
import 'package:pos_lab/style/color.dart';
import 'qty_button.dart';

class CartItemTile extends StatelessWidget {
  const CartItemTile({
    super.key,
    required this.item,
    required this.onIncrease,
    required this.onDecrease,
    required this.onDelete,
  });

  final CartItem item;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onDelete;

  String getSugarDisplay(String sugar) {
    const textKeys = [
      'normal_plus',
      'no_sugar',
      'less_sweet',
      'extra_sweet',
      'standard',
      'sweet',
      'double_sugar',
    ];

    if (textKeys.contains(sugar.toLowerCase())) {
      return sugar.tr;
    }
    return sugar;
  }

  String _formatSugar(String val) {
    if (val.contains('%')) return val;

    // Safety Map in case Khmer text was accidentally saved
    final Map<String, String> safetyMap = {
      'less_sweet': 'មិនសូវផ្អែម',
      'normal_plus': 'ផ្អែមល្មម',
      'standard': 'ធម្មតា',
      'sweet': 'ផ្អែម',
      'extra_sweet': 'ផ្អែមខ្លាំង',
      'double_sugar': 'កាត់ជើង',
    };

    String key = safetyMap[val] ?? val;
    return key.tr; // Translates "no_sugar" -> "No Sugar" or "គ្មានស្ករ"
  }

  @override
  Widget build(BuildContext context) {
    final SettingController controller = Get.find<SettingController>();

    return Obx(() {
      final bool isDark = controller.isDark;
      return Dismissible(
        key: ValueKey(item.id),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            color: Colors.red.shade400,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        onDismissed: (_) => onDelete(),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: isDark ? AppColor.col6 : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: isDark
                ? Border.all(
                    color: AppColor.col5.withValues(alpha: 0.3),
                    width: 1.5,
                    strokeAlign: BorderSide.strokeAlignOutside,
                  )
                : Border.all(color: Colors.transparent, width: 1.0),
            boxShadow: [
              BoxShadow(
                color: isDark ? Colors.black45 : Colors.black26,
                blurRadius: 2,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAE2DA),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    item.product.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.coffee, color: Colors.black54);
                    },
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.product.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 2),

                    // Inside the build method, find your Text widget:

                    // Inside your Build method:
                    Text(
                      "${"size".tr}: ${item.size.tr} • ${"sugar".tr}: ${_formatSugar(item.sugarPercent)}",
                      style: TextStyle(
                        // Respects your Dark Mode settings
                        color: isDark ? Colors.white70 : Colors.grey,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      '\$${item.product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        color: isDark ? AppColor.col4 : AppColor.col6,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              Row(
                children: [
                  QtyButton(icon: Icons.remove, onTap: onDecrease),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ValueListenableBuilder<int>(
                      valueListenable: item.qtyNotifier,
                      builder: (_, qty, __) {
                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 120),
                          transitionBuilder: (child, anim) =>
                              ScaleTransition(scale: anim, child: child),
                          child: Text(
                            '$qty',
                            key: ValueKey(qty),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  QtyButton(icon: Icons.add, onTap: onIncrease),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
