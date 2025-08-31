import 'package:flutter/material.dart';

class PersonName extends StatelessWidget {
  final String personName;

  const PersonName({super.key, required this.personName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 30,
        top: 20,
        bottom: 15,
      ),
      child: Text(
        personName,
        style: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontSize: 40,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,
            ),
      ),
    );
  }
}
