import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_lab/models/product.dart';
import 'package:pos_lab/style/color.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onAdd;

<<<<<<< HEAD
  const ProductCard({
    super.key,
    required this.product,
    required this.onAdd,
  });
=======
  const ProductCard({super.key, required this.product, required this.onAdd});
>>>>>>> new-api

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
<<<<<<< HEAD
          BoxShadow(
            color: Colors.black45,
            blurRadius: 2,
            offset: Offset(2, 2),
          ),
=======
          BoxShadow(color: Colors.black45, blurRadius: 2, offset: Offset(2, 2)),
>>>>>>> new-api
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image + favorite icon
          ClipRRect(
<<<<<<< HEAD
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(12),
            ),
=======
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
>>>>>>> new-api
            child: Stack(
              children: [
                Container(
                  height: 120,
                  width: double.infinity,
                  color: const Color(0xFFF3F4F5),
<<<<<<< HEAD
                  child: Image.asset(
                    product.image,
=======
                  child: Image.network(
                    product.imageUrl,
>>>>>>> new-api
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.image_not_supported,
                      size: 40,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white38,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      CupertinoIcons.heart_fill,
                      size: 20,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Name, category, price, add button
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColor.col5,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
<<<<<<< HEAD
                  product.category,
=======
                  product.categoryName,
>>>>>>> new-api
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColor.col5,
                        fontSize: 16,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: onAdd,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF7B4F2C),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.add,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
