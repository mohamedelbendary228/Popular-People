import 'package:flutter/material.dart';
import 'package:popular_people/features/popular_people/view/popular_people_page.dart';
import 'package:popular_people/routes/route_names.dart';

mixin AppRouter {
  static MaterialPageRoute<dynamic> router(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.popularPeoplePage:
        return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: RouteNames.popularPeoplePage),
          builder: (BuildContext context) => const PopularPeoplePage(),
        );
      default:
        return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: RouteNames.popularPeoplePage),
          builder: (BuildContext context) => const PopularPeoplePage(),
        );
    }
  }
}
