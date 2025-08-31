import 'package:flutter/material.dart';
import 'package:popular_people/features/popular_people/view/widgets/popular_people_app_bar.dart';
import 'package:popular_people/features/popular_people/view/widgets/popular_people_list.dart';

class PopularPeoplePage extends StatelessWidget {
  const PopularPeoplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PopularPeopleAppBar(),
      body: PopularPeopleList(),
    );
  }
}
