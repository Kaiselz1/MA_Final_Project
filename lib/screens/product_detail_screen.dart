import 'package:flutter/material.dart';
import 'package:pos_lab/controllers/cart_controller.dart';
import 'package:pos_lab/models/product.dart';
import 'package:pos_lab/repositories/product_repo.dart';
import 'package:pos_lab/screens/checkout_screen.dart';
import 'package:pos_lab/style/color.dart';
import 'package:pos_lab/widgets/size_selector_widget.dart';
import 'package:pos_lab/widgets/sugar_selector_widget.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late final CartController controller;

  @override
  void initState() {
    super.initState();
    controller = CartController();
  }

  bool isExpanded = false;
  int quantity = 1;
  bool isFavorite = false;

  // Sugar & Size State
  SugarMode activeSugar = SugarMode.percentage;
  double sugarVal = 50.0;
  String currentSweetness = "Standard";
  bool showSlider = false;
  String currentSize = "Normal";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  widget.product.image,
                  width: double.infinity,
                  height: 320,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 40,
                  left: 20,
                  child: _buildCircleBtn(
                    Icons.arrow_back_ios_new,
                    () => Navigator.pop(context),
                  ),
                ),
                Positioned(top: 40, right: 20, child: _buildAnimatedHeart()),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.product.name,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            height: 1.1,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "\$${widget.product.price.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: AppColor.col5,
                          height: 1.1,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    widget.product.category,
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                  ),

                  const Divider(height: 30),

                  _buildQuantitySection(),

                  const SizedBox(height: 25),

                  const Text(
                    "Description",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.product.description,
                    maxLines: isExpanded ? null : 2,
                    overflow: isExpanded
                        ? TextOverflow.visible
                        : TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.grey, height: 1.5),
                  ),
                  GestureDetector(
                    onTap: () => setState(() => isExpanded = !isExpanded),
                    child: Text(
                      isExpanded ? "See Less" : "See More",
                      style: const TextStyle(
                        color: Colors.brown,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),
                  const Text(
                    "Sugar",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),

                  SugarSelector(
                    activeMode: activeSugar,
                    percentage: sugarVal,
                    selectedSweetness: currentSweetness,
                    showSlider: showSlider,
                    onChanged: (mode, {percent, sweetness, toggleSlider}) {
                      setState(() {
                        activeSugar = mode;
                        if (percent != null) sugarVal = percent;
                        if (sweetness != null) currentSweetness = sweetness;
                        showSlider = toggleSlider ?? false;
                        if (mode == SugarMode.none) sugarVal = 0;
                      });
                    },
                  ),

                  SizedBox(height: 15),

                  Text(
                    "Size",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizeSelector(
                    selectedSize: currentSize,
                    onSelect: (size) => setState(() => currentSize = size),
                  ),

                  const SizedBox(height: 30),

                  _buildBottomButtons(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleBtn(IconData icon, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(color: Colors.white38, shape: BoxShape.circle),
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: 20),
        onPressed: onTap,
      ),
    );
  }

  Widget _buildAnimatedHeart() {
    return Container(
      decoration: BoxDecoration(color: Colors.white38, shape: BoxShape.circle),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 1.0, end: isFavorite ? 1.3 : 1.0),
        duration: const Duration(milliseconds: 200),
        builder: (context, val, child) => Transform.scale(
          scale: val,
          child: IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: () => setState(() => isFavorite = !isFavorite),
          ),
        ),
      ),
    );
  }

  Widget _buildQuantitySection() {
    return Row(
      children: [
        const Text(
          "Quantity",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 20),
        _qtyBtn(Icons.remove, Colors.red, () {
          if (quantity > 1) setState(() => quantity--);
        }),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            "$quantity",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        // _qtyBtn(Icons.remove, Colors.red, () {
        //   if (quantity > 1) setState(() => quantity--);
        // }
        _qtyBtn(Icons.add, Colors.cyan, () => setState(() => quantity++)),
      ],
    );
  }

  Widget _qtyBtn(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Icon(icon, size: 20, color: color),
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              for (int i = 0; i < quantity; i++) {
                ProductRepo.addProductToCart(
                  widget.product,
                  size: currentSize,
                  sweetness: currentSweetness,
                  sugarPercent: sugarVal,
                );
              }
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("Added to cart")));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.col4,
              foregroundColor: Colors.white,
              elevation: 0,
              shadowColor: Colors.black38,
              minimumSize: const Size(0, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
            ),
            child: const Text(
              "Add to Cart",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: ElevatedButton(
            onPressed: () {
              for (int i = 0; i < quantity; i++) {
                ProductRepo.addProductToCart(widget.product);
              }
              controller.proceedToCheckout(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.col5,
              foregroundColor: Colors.white,
              elevation: 0,
              shadowColor: Colors.black38,
              minimumSize: const Size(0, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
            ),
            child: const Text(
              "Check Out",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }
}
