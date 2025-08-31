import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:popular_people/core/models/person.dart';

class PersonInfo extends StatelessWidget {
  final Person person;

  const PersonInfo({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    final infoTextColor =
        Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white;
    return Container(
      padding: const EdgeInsetsDirectional.only(
        start: 30,
        end: 17,
        bottom: 20,
      ),
      child: Row(
        children: [
          if (person.knownForDepartment != null)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Known For',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: infoTextColor.withOpacity(0.5),
                        ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    person.knownForDepartment!,
                    style: Theme.of(context).primaryTextTheme.headlineMedium,
                  ),
                ],
              ),
            ),
          if (person.birthday != null)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Birthday',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: infoTextColor.withOpacity(0.5),
                        ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    DateFormat('dd-MM-yyyy').format(person.birthday!),
                    style: Theme.of(context).primaryTextTheme.headlineMedium,
                  ),
                ],
              ),
            ),
          // Expanded(),
        ],
      ),
    );
  }
}
