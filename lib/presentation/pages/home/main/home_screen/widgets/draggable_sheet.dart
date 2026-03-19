// presentation/pages/home/main/home_screen/widgets/draggable_sheet.dart

import 'package:flutter/material.dart';

import '../../../../../../constants/rosponsive_helper.dart';

import '../../../channels/channels_page.dart';
import '../../../chats/messages_page.dart';
import '../../../status/status_page.dart';




class DraggableSheetContent extends StatelessWidget {
  final Responsive r;
  final ScrollController scrollController;
  final PageController pageController;
  final List<String> items;
  final int currentIndex;
  final ValueChanged<int> onPageChanged;

  const DraggableSheetContent({
    super.key,
    required this.r,
    required this.scrollController,
    required this.pageController,
    required this.items,
    required this.currentIndex,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return 
     Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(r.w(0.1)),
          topRight: Radius.circular(r.w(0.1)),
        ),
      ),
      child: Column(
        children: [

          Container(
            width: r.w(0.12),
            height: r.h(0.07),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
          ),

Expanded(
  child: SingleChildScrollView(
    controller: scrollController, 
    child: SizedBox(
      height: MediaQuery.of(context).size.height,
      child: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: const ClampingScrollPhysics(),
        children: const [
          MessagesPage(),
          GroupPage(),
          StatusPage(),
        ],
      ),
    ),
  ),
),
          PageIndicator(
            items: items,
            currentIndex: currentIndex,
          ),

          SizedBox(height: r.h(0.03)),
        ],
      ),
    );
  }
}



class PageIndicator extends StatelessWidget {
  final int currentIndex;
  final List<String> items;

  const PageIndicator({
    super.key,
    required this.items,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(items.length, (index) {
        final isSelected = index == currentIndex;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          margin: EdgeInsets.symmetric(horizontal: r.w(0.015)),
          width: isSelected ? r.w(0.25) : r.w(0.03),
          height: isSelected ? r.h(0.04) : r.h(0.01),
          decoration: BoxDecoration(
            color: isSelected ? Colors.transparent : Colors.grey.shade400,
            borderRadius: BorderRadius.circular(r.w(0.1)),
          ),
          child: isSelected
              ? Center(
                  child: Image.asset(
                    items[index],
                    width: r.w(0.2),
                    fit: BoxFit.contain,
                  ),
                )
              : null,
        );
      }),
    );
  }
}