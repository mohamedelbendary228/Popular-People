import 'package:flutter/material.dart';
import 'package:popular_people/core/enums/gender.dart';
import 'package:popular_people/features/popular_people/view/widgets/person_avatar.dart';

class PopularPeopleListItem extends StatelessWidget {
  const PopularPeopleListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      child: Row(
        children: [
          const Expanded(
            child: PersonAvatar(
              avatarUrl: null,
              gender: Gender.male,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 3,
            child: Text(
              "Peter Stormare",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
        ],
      ),
    );
  }
}
