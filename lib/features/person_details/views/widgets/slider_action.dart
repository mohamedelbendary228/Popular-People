import 'package:flutter/material.dart';
import 'package:popular_people/core/theme/app_colors.dart';

class SliderAction extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onTap;
  final Color color;

  const SliderAction({
    super.key,
    required this.icon,
    this.onTap,
    this.color = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipOval(
        child: Material(
          color: color,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: icon,
            ),
          ),
        ),
      ),
    );
  }
}
