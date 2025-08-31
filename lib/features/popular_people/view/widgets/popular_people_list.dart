import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popular_people/core/widgets/error_widget.dart';
import 'package:popular_people/core/models/person.dart';
import 'package:popular_people/features/popular_people/providers/paginated_popular_people_provider.dart';
import 'package:popular_people/features/popular_people/providers/popular_people_count_provider.dart';
import 'package:popular_people/features/popular_people/providers/popular_people_list_scroll_controller.dart';
import 'package:popular_people/features/popular_people/view/widgets/popular_people_list_item.dart';
import 'package:popular_people/features/popular_people/view/widgets/popular_people_list_shimmer.dart';

final isForceRefreshing = StateProvider<bool>((_) => false);

class PopularPeopleList extends ConsumerWidget {
  const PopularPeopleList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = ref.watch(popularPeopleScrollControllerProvider);
    final popularPeopleCount = ref.watch(popularPeopleCountProvider);

    return popularPeopleCount.when(
      loading: () => const PopularPeopleListShimmer(),
      data: (int count) {
        return RefreshIndicator(
          color: Theme.of(context).primaryColor,
          onRefresh: () async {
            ref.read(isForceRefreshing.notifier).state = true;
          },
          child: ListView.builder(
            controller: scrollController,
            itemCount: count,
            itemExtent: 110,
            itemBuilder: (context, index) {
              final AsyncValue<Person> currentPopularPersonFromIndex = ref
                  .watch(paginatedPopularPeopleProvider(index ~/ 20))
                  .whenData((paginatedData) => paginatedData.results[index % 20]);
              return PopularPeopleListItem(
                personAsync: currentPopularPersonFromIndex,
              );
            },
          ),
        );
      },
      error: (Object error, StackTrace? stackTrace) {
        log('Error fetching popular people');
        log(error.toString());
        log(stackTrace.toString());
        return const ErrorView();
      },
    );
  }
}
