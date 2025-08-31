import 'package:flutter/material.dart';
import 'package:popular_people/core/enums/gender.dart';
import 'package:popular_people/features/person_details/views/widgets/person_details_sliver_app_bar.dart';
import 'package:popular_people/features/person_details/views/widgets/person_name.dart';
import 'package:popular_people/core/models/media.dart';

class PersonDetailsPage extends StatelessWidget {
  final int personId;
  final String personName;
  final String? personAvatar;
  final Gender personGender;
  final List<Media> personMedia;
  const PersonDetailsPage({
    super.key,
    required this.personId,
    required this.personName,
    required this.personAvatar,
    required this.personGender,
    this.personMedia = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          PersonDetailsSliverAppBar(
            personId: personId,
            avatar: personAvatar,
            gender: personGender,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              PersonName(personName: personName),
            ]),
          ),
        ],
      ),
    );
  }
}
