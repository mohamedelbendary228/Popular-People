import 'package:flutter/material.dart';
import 'package:popular_people/core/configs/flavor_config.dart';

class FlavorBanner extends StatelessWidget {
  final Widget child;

  const FlavorBanner({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    if (FlavorConfig.isProduction() && !hasBeenNonProduction!) return child;
    return Stack(
      children: <Widget>[child, _buildBanner(context)],
    );
  }

  Widget _buildBanner(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: CustomPaint(
        painter: BannerPainter(
          message: FlavorConfig.instance.values.mobileAppVersion!,
          textDirection: Directionality.of(context),
          layoutDirection: Directionality.of(context),
          location: BannerLocation.topStart,
          color: FlavorConfig.instance.color!,
        ),
      ),
    );
  }
}
