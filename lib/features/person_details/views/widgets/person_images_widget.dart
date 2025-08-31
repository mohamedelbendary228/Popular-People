import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popular_people/core/widgets/error_widget.dart';
import 'package:popular_people/features/person_details/models/person_images.dart';
import 'package:popular_people/features/person_details/providers/person_imags_provider.dart';
import 'package:popular_people/features/person_details/views/widgets/grid_shimmer.dart';
import 'package:popular_people/features/person_details/views/widgets/person_images_grid.dart';

/// Widget holding horizontal list of a person's images
class PersonImagesWidget extends ConsumerWidget {
  final int personId;

  const PersonImagesWidget({super.key, required this.personId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(
            top: 20,
            bottom: 20,
          ),
          child: ref.watch(personImagesProvider(personId)).when(
            data: (List<PersonImage> images) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 30, end: 17),
                    child: Text(
                      'Images',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  const SizedBox(height: 20),
                  PersonImagesGrid(images),
                ],
              );
            },
            error: (Object error, StackTrace? stackTrace) {
              log('Error fetching person images');
              log(error.toString());
              log(stackTrace.toString());
              return const ErrorView();
            },
            loading: () {
              return Padding(
                padding: const EdgeInsetsDirectional.only(start: 40 - 17, end: 17),
                child: GridShimmer(
                  key: ValueKey('person_${personId}_images_grid'),
                  minOpacity: 0.2,
                  maxOpacity: 0.3,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
