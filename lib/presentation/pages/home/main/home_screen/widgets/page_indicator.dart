// presentation/pages/home/main/home_screen/widgets/page_indicator.dart
import 'package:flutter/material.dart';
import '../../../../../../constants/rosponsive_helper.dart';

class PageIndicator extends StatelessWidget {
  final int currentIndex;
  final List<String> items;

  const PageIndicator({super.key, required this.items, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(items.length, (index) {
        final bool isSelected = index == currentIndex;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          width: isSelected ? 120 : 10,
          height: isSelected ? 32 : 10,
          decoration: BoxDecoration(
            color: isSelected ? Colors.transparent : Colors.grey.shade400,
            borderRadius: BorderRadius.circular(30),
          ),
          child: isSelected
              ? Center(
                  child: Image.asset(
                    items[index],
                    width: 100,
                    height: r.h(0.1),
                  ),
                )
              : null,
        );
      }),
    );
  }
}
