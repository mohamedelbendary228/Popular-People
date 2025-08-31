import 'package:flutter/material.dart';
import 'package:popular_people/core/theme/app_colors.dart';

class AppBarBackButton extends StatefulWidget {
  const AppBarBackButton({super.key});

  @override
  State<AppBarBackButton> createState() => _AppBarBackButtonState();
}

class _AppBarBackButtonState extends State<AppBarBackButton> with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> fadeAnimation;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();

    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.5, 1, curve: Curves.easeInOut),
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: Center(
        child: ClipOval(
          child: Material(
            color: AppColors.primary,
            child: InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: Icon(Icons.arrow_back),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
