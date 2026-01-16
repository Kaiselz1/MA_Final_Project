import 'package:get/get.dart';

class CounterController extends GetxController {
  var count = 0.obs;

  void increase() {
    count.value += 1;
  }

  void decrease() {
    count.value -= 1;
  }
}
