import 'package:flutter/cupertino.dart';
import 'package:pos_lab/models/product.dart';
import 'package:pos_lab/widgets/product_card_widget.dart';

class ProductGrid extends StatelessWidget {
  final List<Product> products;
  final Function(Product) onAdd;

<<<<<<< HEAD
  const ProductGrid({
    super.key,
    required this.products,
    required this.onAdd,
  });
=======
  const ProductGrid({super.key, required this.products, required this.onAdd});
>>>>>>> new-api

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 0.75,
<<<<<<< HEAD
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: products.map((product) {
        return ProductCard(
          product: product,
          onAdd: () => onAdd(product),
        );
=======
      // primary: true,
      shrinkWrap: true,
      // physics: const NeverScrollableScrollPhysics(),
      children: products.map((product) {
        return ProductCard(product: product, onAdd: () => onAdd(product));
>>>>>>> new-api
      }).toList(),
    );
  }
}
