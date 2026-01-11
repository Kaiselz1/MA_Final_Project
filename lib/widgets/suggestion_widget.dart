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
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: widget.suggestions.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() => selectedIndex = index);
              widget.onSelected(widget.suggestions[index]);
            },
            child: Container(
              margin: const EdgeInsets.only(right: 12, bottom: 4),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColor.col3,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
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
      
    );
    
  }
}
