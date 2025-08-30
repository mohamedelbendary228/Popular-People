import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator.adaptive(
        valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
