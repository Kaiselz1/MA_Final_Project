import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_lab/controllers/counter_controller.dart';
import 'package:pos_lab/style/color.dart';
import 'package:flutter/foundation.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreen();
}

class _FavoriteScreen extends State<FavoriteScreen>
    with AutomaticKeepAliveClientMixin {
  final CounterController counterController = Get.put(CounterController());

  @override
  void initState() {
    if (kDebugMode) {
      print('object');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      backgroundColor: AppColor.col8,

      body: Stack(
        children: [
          Column(
            children: [
              // ================= Body =================
            ],
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
