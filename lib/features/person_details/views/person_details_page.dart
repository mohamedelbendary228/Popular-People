import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popular_people/core/enums/gender.dart';
import 'package:popular_people/core/models/person.dart';
import 'package:popular_people/core/widgets/error_widget.dart';
import 'package:popular_people/core/widgets/loading_widget.dart';
import 'package:popular_people/features/person_details/providers/person_details_provider.dart';
import 'package:popular_people/features/person_details/views/widgets/person_bio.dart';
import 'package:popular_people/features/person_details/views/widgets/person_details_sliver_app_bar.dart';
import 'package:popular_people/features/person_details/views/widgets/person_images_widget.dart';
import 'package:popular_people/features/person_details/views/widgets/person_info.dart';
import 'package:popular_people/features/person_details/views/widgets/person_name.dart';
import 'package:popular_people/core/models/media.dart';

class PersonDetailsPage extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final personAsync = ref.watch(personDetailsProvider(personId));
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
              personAsync.when(
                data: (Person person) {
                  return Column(
                    children: [
                      PersonInfo(person: person),
                      PersonImagesWidget(personId: personId),
                      PersonBio(biography: person.biography),
                      const SizedBox(height: 20),
                    ],
                  );
                },
                error: (Object error, StackTrace? stackTrace) {
                  log('Error fetching person details');
                  log(error.toString());
                  return const ErrorView();
                },
                loading: () => const LoadingWidget(),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
