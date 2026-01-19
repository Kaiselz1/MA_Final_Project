import 'package:get/get.dart';
import 'package:pos_lab/api/api_base_url.dart';
import 'package:pos_lab/api/api_end_point.dart';
import 'package:pos_lab/models/category.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryController extends GetxController {
  var categories = <Category>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    if (categories.isNotEmpty) return; // Already fetched, skip
    try {
      final response = await http.get(
        Uri.parse(ApiBaseUrl.baseUrl + ApiEndPoint.categories),
        headers: {"accept": "application/json"},
      );

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        categories.value = data.map((e) => Category.fromJson(e)).toList();
        print("Fetched ${categories.length} categories");
      }
    } catch (e) {
      print("API error (categories): $e");
    } finally {
      isLoading.value = false;
    }
  }
}
