import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pos_lab/style/color.dart';

class SuggestionList extends StatefulWidget {
  final List<String> suggestions;
  final Function(String) onSelected;
  const SuggestionList({
    super.key,
    required this.suggestions,
    required this.onSelected,
  });

  @override
  State<SuggestionList> createState() => _SuggestionListState();
}

class _SuggestionListState extends State<SuggestionList> {
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.suggestions.isNotEmpty
        ? widget.suggestions[0]
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse, // allows dragging with mouse on web
          },
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          primary: false,
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          dragStartBehavior: DragStartBehavior.start, // <-- ADD THIS
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: widget.suggestions.length,
          itemBuilder: (context, index) {
            final category = widget.suggestions[index];
            final isSelected = category == selectedCategory;

            return GestureDetector(
              onTap: () {
                setState(() => selectedCategory = category);
                widget.onSelected(category);
              },
              child: Container(
                margin: const EdgeInsets.only(right: 12, bottom: 4),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColor.col3,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: isSelected ? AppColor.col5 : AppColor.col3,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    widget.suggestions[index],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
