import 'package:flutter/material.dart';
import 'package:popular_people/core/widgets/shimmer.dart';

class GridShimmer extends StatelessWidget {
  final double minOpacity;
  final double maxOpacity;

  const GridShimmer({
    super.key,
    this.minOpacity = 0.05,
    this.maxOpacity = 0.1,
  });

  @override
  Widget build(BuildContext context) {
    final itemHeight = (MediaQuery.of(context).size.width - 17 * 2 - 10 * 2) / 3;

    return SizedBox(
      height: itemHeight * 3 + 10 * 4,
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: List.generate(
          9,
          (index) => Shimmer(
            height: itemHeight,
            minOpacity: minOpacity,
            maxOpacity: maxOpacity,
          ),
        ),
      ),
    );
  }
}
