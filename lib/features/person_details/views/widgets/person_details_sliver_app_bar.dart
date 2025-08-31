import 'package:flutter/material.dart';
import 'package:popular_people/core/enums/gender.dart';
import 'package:popular_people/features/person_details/views/widgets/app_bar_backButton.dart';
import 'package:popular_people/features/person_details/views/widgets/person_cover.dart';

class PersonDetailsSliverAppBar extends StatelessWidget {
  final int personId;
  final String? avatar;
  final Gender gender;

  const PersonDetailsSliverAppBar({
    super.key,
    this.avatar,
    this.gender = Gender.unknown,
    required this.personId,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height * 0.35,
      collapsedHeight: 100,
      leadingWidth: 70,
      backgroundColor: Colors.transparent,
      leading: const AppBarBackButton(),
      pinned: true,
      flexibleSpace: Hero(
        tag: 'person_${personId}_profile',
        transitionOnUserGestures: true,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
          child: PersonCover(
            avatar,
            gender: gender,
            height: double.infinity,
          ),
        ),
      ),
    );
  }
}
