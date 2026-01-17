import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_lab/models/cart_items.dart';
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

  @override
  Widget build(BuildContext context) {
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFFEAE2DA),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  item.product.image,
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
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),

      const SizedBox(height: 4),

      Text(
        'Size: ${item.size} • Sugar: ${item.sugarPercent.toInt()}% ',
        style: const TextStyle(
          fontSize: 13,
          color: Colors.grey,
        ),
      ),

      const SizedBox(height: 6),

      Text(
        '\$${item.product.price.toStringAsFixed(2)}',
        style: const TextStyle(
          fontSize: 14,
          color: Colors.brown,
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
  }
}
