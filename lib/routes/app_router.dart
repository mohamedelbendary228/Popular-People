import 'package:flutter/material.dart';
import 'package:popular_people/features/person_details/views/pages/person_details_page.dart';
import 'package:popular_people/features/popular_people/view/pages/popular_people_page.dart';
import 'package:popular_people/routes/route_names.dart';

mixin AppRouter {
  static MaterialPageRoute<dynamic> router(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.popularPeoplePage:
        return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: RouteNames.popularPeoplePage),
          builder: (BuildContext context) => const PopularPeoplePage(),
        );
      case RouteNames.personDetailsPage:
        return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: RouteNames.popularPeoplePage),
          builder: (BuildContext context) {
            final args = settings.arguments as Map<String, dynamic>;
            return PersonDetailsPage(
              personId: args['personId'],
              personName: args['personName'],
              personAvatar: args['personAvatar'],
              personGender: args['personGender'],
              personMedia: args['personMedia'],
            );
          },
        );
      default:
        return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: RouteNames.popularPeoplePage),
          builder: (BuildContext context) => const PopularPeoplePage(),
        );
    }
  }
}
