import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_lab/controllers/counter_controller.dart';
import 'package:pos_lab/controllers/main_controller.dart';
import 'package:pos_lab/controllers/setting_controller.dart';
import 'package:pos_lab/style/color.dart';
import 'package:flutter/foundation.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with AutomaticKeepAliveClientMixin {
  final CounterController counterController = Get.put(CounterController());
  final SettingController controller = Get.find<SettingController>();
  final String _selectedhistoryPath = "history";

  @override
  void initState() {
    if (kDebugMode) {
      print('HistoryScreen initialized');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required by AutomaticKeepAliveClientMixin

    return Obx(() {
      final bool isDark = Theme.of(context).brightness == Brightness.dark;

      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.find<MainController>().currentIndex.value = 0;
                      Navigator.maybePop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                      color: AppColor.col5,
                    ),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () => Navigator.maybePop(context),
                    child: Text(
                      "home",
                      style: TextStyle(
                        color: isDark ? AppColor.col4 : Colors.black45,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Text(
                    " / ",
                    style: TextStyle(
                      color: isDark ? AppColor.col4 : Colors.black45,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    _selectedhistoryPath,
                    style: TextStyle(
                      color: isDark ? AppColor.col4 : Colors.black45,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.history_rounded,
                      size: 60,
                      color: isDark ? Colors.white10 : Colors.black12,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "No transactions yet",
                      style: TextStyle(
                        color: isDark ? Colors.white54 : Colors.black54,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}
