import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popular_people/features/popular_people/providers/popular_people_list_scroll_controller.dart';

class PopularPeopleAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const PopularPeopleAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final popularPeopleScrollController = ref.watch(popularPeopleScrollControllerProvider);
    return AppBar(
      title: GestureDetector(
        key: const ValueKey('app_bar_title_gesture_detector'),
        onTap: () => popularPeopleScrollController.animateTo(
          popularPeopleScrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        ),
        child: const Text('Popular'),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
