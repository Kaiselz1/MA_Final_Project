import 'package:get/get.dart';
import 'package:pos_lab/api/api_base_url.dart';
import 'package:pos_lab/api/api_end_point.dart';
import 'package:pos_lab/models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductController extends GetxController {
  var products = <Product>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    if (products.isNotEmpty) return; // <-- Already fetched, skip
    try {
      final response = await http.get(
        Uri.parse(ApiBaseUrl.baseUrl + ApiEndPoint.products),
        headers: {"accept": "application/json"},
      );
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        products.value = data.map((e) => Product.fromJson(e)).toList();
      }
    } catch (e) {
      print("API error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
