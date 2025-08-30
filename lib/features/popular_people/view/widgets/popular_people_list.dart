import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popular_people/features/popular_people/providers/popular_people_list_scroll_controller.dart';
import 'package:popular_people/features/popular_people/view/widgets/popular_people_list_item.dart';

class PopularPeopleList extends ConsumerWidget {
  const PopularPeopleList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = ref.watch(popularPeopleScrollControllerProvider);
    return ListView.builder(
      controller: scrollController,
      itemCount: 20,
      itemExtent: 110,
      itemBuilder: (context, index) {
        return const PopularPeopleListItem();
      },
    );
  }
}
