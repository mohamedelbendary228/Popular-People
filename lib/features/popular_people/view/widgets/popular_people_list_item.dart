import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popular_people/core/widgets/error_widget.dart';
import 'package:popular_people/features/popular_people/models/person.dart';
import 'package:popular_people/features/popular_people/view/widgets/popular_people_item_shimmer.dart';
import 'package:popular_people/features/popular_people/view/widgets/person_avatar.dart';

class PopularPeopleListItem extends StatelessWidget {
  final AsyncValue<Person> personAsync;
  const PopularPeopleListItem({super.key, required this.personAsync});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: personAsync.when(
        data: (Person person) {
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            child: Row(
              children: [
                // Avatar
                Expanded(
                  child: Hero(
                    tag: 'person_${person.id}_profile_picture',
                    transitionOnUserGestures: true,
                    child: PersonAvatar(
                      avatarUrl: person.avatar,
                      gender: person.gender,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 3,
                  child: Text(
                    person.name,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
              ],
            ),
          );
        },
        error: (Object error, StackTrace? stackTrace) {
          log('Error fetching current popular person');
          log(error.toString());
          return const ErrorView();
        },
        loading: () => const PopularPeopleItemShimmer(),
      ),
    );
  }
}
