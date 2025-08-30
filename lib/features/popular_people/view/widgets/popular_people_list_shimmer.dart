import 'package:flutter/material.dart';
import 'package:popular_people/features/popular_people/view/widgets/popular_people_item_shimmer.dart';

class PopularPeopleListShimmer extends StatelessWidget {
  const PopularPeopleListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: ScrollController(),
      itemCount: 10,
      itemExtent: 110,
      itemBuilder: (context, index) {
        return const PopularPeopleItemShimmer();
      },
    );
  }
}
