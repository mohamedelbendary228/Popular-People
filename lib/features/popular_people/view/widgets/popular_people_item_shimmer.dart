import 'package:flutter/material.dart';
import 'package:popular_people/core/widgets/shimmer.dart';

class PopularPeopleItemShimmer extends StatelessWidget {
  const PopularPeopleItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            flex: 1,
            child: Shimmer(height: 90),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Shimmer(height: 15),
                const SizedBox(height: 20),
                Shimmer(
                  height: 15,
                  width: MediaQuery.of(context).size.width * 0.4,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
